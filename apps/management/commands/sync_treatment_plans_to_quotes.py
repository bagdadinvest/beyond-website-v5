#!/usr/bin/env python
"""
Django Management Command: sync_treatment_plans_to_quotes
Syncs TreatmentPlan models from Django to Invoice Ninja as quotes.
Handles the complex discount mapping from individual product discounts to Invoice Ninja's global discount system.
"""

from django.core.management.base import BaseCommand
from django.utils import timezone
from apps.models import TreatmentPlan, TreatmentPlanItem, User
from decimal import Decimal, ROUND_HALF_UP
import requests
import json
import os
import time
from datetime import datetime, timedelta

class Command(BaseCommand):
    help = 'Sync TreatmentPlan models to Invoice Ninja as quotes'

    def add_arguments(self, parser):
        parser.add_argument('--count', type=int, default=10, help='Number of treatment plans to sync per run (default 10)')
        parser.add_argument('--dry-run', action='store_true', help='Print only, do not post or update')
        parser.add_argument('--force-update', action='store_true', help='Update existing quotes in Invoice Ninja')
        parser.add_argument('--plan-id', type=int, help='Sync specific treatment plan by ID')

    def handle(self, *args, **options):
        count = options['count']
        dry_run = options['dry_run']
        force_update = options['force_update']
        plan_id = options['plan_id']

        self.stdout.write(f"\n🚀 Treatment Plan to Quote Sync")
        self.stdout.write("="*60)

        # Filter treatment plans to sync
        if plan_id:
            plans = TreatmentPlan.objects.filter(id=plan_id)
            if not plans.exists():
                self.stdout.write(self.style.ERROR(f"❌ Treatment Plan with ID {plan_id} not found"))
                return
        else:
            # Get plans that haven't been synced yet, or need updating if force_update is True
            if force_update:
                plans = TreatmentPlan.objects.all()[:count]
            else:
                plans = TreatmentPlan.objects.filter(
                    invoiceninja_quote_id__isnull=True
                )[:count]

        if not plans.exists():
            self.stdout.write("✅ No treatment plans pending sync.")
            return

        self.stdout.write(f"📋 Found {plans.count()} treatment plans to sync")
        self.stdout.write("-" * 60)

        success_count = 0
        error_count = 0

        for idx, plan in enumerate(plans, 1):
            self.stdout.write(f"\n[{idx}/{plans.count()}] Processing: Treatment Plan {plan.id}")
            self.stdout.write(f"   Patient: {plan.patient.get_full_name()}")
            self.stdout.write(f"   Doctor: {plan.doctor.get_full_name()}")
            self.stdout.write(f"   Total: ${plan.total_price}")
            
            # Check if plan already exists in Invoice Ninja
            if hasattr(plan, 'invoiceninja_quote_id') and plan.invoiceninja_quote_id and not force_update:
                self.stdout.write(f"⏭️  Plan already synced (Invoice Ninja Quote ID: {plan.invoiceninja_quote_id})")
                continue

            # First, ensure the patient exists as a client in Invoice Ninja
            client_id = self.ensure_client_exists(plan.patient, dry_run)
            if not client_id and not dry_run:
                self.stdout.write(self.style.ERROR(f"❌ Failed to ensure client exists for patient {plan.patient.get_full_name()}"))
                error_count += 1
                continue

            data = self.build_quote_data(plan, client_id)
            self.stdout.write("[QUOTE DATA TO POST]\n" + json.dumps(data, indent=2, default=str))

            if dry_run:
                self.stdout.write("[DRY RUN] Skipping API POST.")
                continue

            # Determine if we should create or update
            if hasattr(plan, 'invoiceninja_quote_id') and plan.invoiceninja_quote_id and force_update:
                result = self.update_in_invoice_ninja(data, plan.invoiceninja_quote_id)
                action = "updated"
            else:
                result = self.create_in_invoice_ninja(data)
                action = "created"

            if result:
                ninja_quote_id = result
                
                # Save the Invoice Ninja quote ID back to our model
                try:
                    plan.invoiceninja_quote_id = ninja_quote_id
                    plan.invoiceninja_sync_status = 'synced'
                    plan.invoiceninja_last_sync_attempt = timezone.now()
                    
                    plan.save(update_fields=[
                        'invoiceninja_quote_id',
                        'invoiceninja_sync_status', 
                        'invoiceninja_last_sync_attempt'
                    ])
                    self.stdout.write(self.style.SUCCESS(f"✅ Quote {action}! Invoice Ninja ID: {ninja_quote_id}"))
                    success_count += 1
                except Exception as e:
                    self.stdout.write(self.style.WARNING(f"⚠️  Quote {action} in Invoice Ninja but failed to update local record: {str(e)}"))
                    success_count += 1
            else:
                self.stdout.write(self.style.ERROR(f"❌ Failed to {action.split('d')[0]} quote in Invoice Ninja"))
                error_count += 1

            # Add a small delay to avoid overwhelming the API
            time.sleep(0.5)

        self.stdout.write(f"\n🎯 Sync Summary:")
        self.stdout.write(f"✅ Successful: {success_count}")
        self.stdout.write(f"❌ Errors: {error_count}")
        self.stdout.write(f"📋 Total processed: {success_count + error_count}")

    def ensure_client_exists(self, patient, dry_run=False):
        """Ensure the patient exists as a client in Invoice Ninja"""
        # Check if patient already has Invoice Ninja client ID
        if hasattr(patient, 'invoiceninja_client_id') and patient.invoiceninja_client_id:
            return patient.invoiceninja_client_id
        
        if dry_run:
            return "TEST_CLIENT_ID"
        
        # If not, we would need to create the client
        # For now, we'll use the existing sync_invoice_ninja_order command's logic
        # This is a simplified version - in production, you might want to call the user sync
        # The sync_invoice_ninja_order command now also captures and saves the client portal URL
        self.stdout.write(f"⚠️  Patient {patient.get_full_name()} not synced to Invoice Ninja yet")
        self.stdout.write(f"   You may want to run: python manage.py sync_invoice_ninja_order --count 1")
        return None

    def build_quote_data(self, plan, client_id):
        """Build Invoice Ninja quote data from TreatmentPlan model"""
        
        # Calculate dates
        quote_date = plan.created_at.strftime('%Y-%m-%d')
        due_date = (plan.created_at + timedelta(days=30)).strftime('%Y-%m-%d')  # 30 days validity
        
        # Build line items from treatment plan items
        line_items = []
        calculated_subtotal = Decimal('0.00')
        discount_details = []
        
        for item in plan.treatmentplanitem_set.all():
            # Get the product key from Invoice Ninja sync
            product_key = ""
            if hasattr(item.product, 'invoiceninja_product_id') and item.product.invoiceninja_product_id:
                # Try to use the synced product key if available
                product_key = item.product.slug or item.product.name.replace(' ', '_').upper()
            else:
                product_key = item.product.slug or item.product.name.replace(' ', '_').upper()
            
            # Calculate line item totals
            line_item_subtotal = item.product.price * item.quantity
            calculated_subtotal += line_item_subtotal
            
            # Track discount details for public notes (using HTML)
            if item.discount_percentage > 0:
                line_item_discount_amount = (line_item_subtotal * item.discount_percentage) / 100
                discount_details.append(f"<strong>{item.product.name}</strong> ({item.quantity}x): -{item.discount_percentage}% = -${line_item_discount_amount:.2f}")
            
            # Send original prices without line-item discounts to Invoice Ninja
            line_item = {
                "product_key": product_key[:50],  # Limit length
                "notes": f"{item.product.name} - {item.product.description[:100] if item.product.description else 'No description'}"[:500],
                "cost": float(item.product.price),
                "quantity": item.quantity,
                "discount": 0,  # No line item discounts - we'll handle total discount
                "tax_name1": "",
                "tax_rate1": 0,
                "tax_name2": "",
                "tax_rate2": 0,
                "custom_value1": item.product.category,
                "custom_value2": str(item.product.country_of_origin) if item.product.country_of_origin else "",
                "custom_value3": f"Django_Plan_{plan.id}_Item_{item.id}",  # Reference back to Django
                "custom_value4": f"Max_Discount_{item.product.max_discount_percentage}%"
            }
            line_items.append(line_item)
        
        # Calculate total discount amount
        # Use the actual total from the plan vs our calculated subtotal
        if plan.total_price and calculated_subtotal > 0:
            total_discount_amount = calculated_subtotal - plan.total_price
        else:
            total_discount_amount = Decimal('0.00')
        
        # Build public notes with treatment plan summary and discount breakdown (using HTML)
        public_notes = f"<h2>Treatment Plan for {plan.patient.get_full_name()}</h2>"
        public_notes += f"<p><strong>Doctor:</strong> Dr. {plan.doctor.get_full_name()}<br>"
        public_notes += f"<strong>Items:</strong> {plan.treatmentplanitem_set.count()} treatment items<br>"
        public_notes += f"<strong>Date:</strong> {quote_date}</p>"
        
        # Add discount breakdown with HTML formatting
        if total_discount_amount > 0:
            public_notes += f"<h3> Discount Breakdown</h3>"
            if discount_details:
                for detail in discount_details:
                    public_notes += f"<li>{detail}</li>"
            if plan.final_discount_percentage > 0:
                public_notes += f"<li><strong>Additional Plan Discount:</strong> {plan.final_discount_percentage}%</li>"
            public_notes += f"</ul>"
            public_notes += f"<hr>"
            public_notes += f"<p><strong>TOTAL DISCOUNT:</strong> ${total_discount_amount:.2f}<br>"
            public_notes += f"<strong>FINAL AMOUNT:</strong> ${plan.total_price:.2f}</p>"
            public_notes += f"<hr>"

        else:
            public_notes += f"<p><strong>TOTAL AMOUNT:</strong> ${plan.total_price:.2f}</p>"
            public_notes += f"<hr>"

        # Build private notes with detailed breakdown
        private_notes = f"Django Treatment Plan ID: {plan.id}\n"
        private_notes += f"Created: {plan.created_at}\n"
        private_notes += f"Last Updated: {plan.updated_at}\n"
        private_notes += f"Calculated Subtotal: ${calculated_subtotal}\n"
        private_notes += f"Total Discount Amount: ${total_discount_amount}\n"
        private_notes += f"Final Total: ${plan.total_price}"

        data = {
            "client_id": client_id,
            "date": quote_date,
            "due_date": due_date,
            "public_notes": public_notes[:2000],  # Increased limit for discount breakdown
            "private_notes": private_notes[:1000],  # Limit length
            "terms": "This quote is valid for 30 days. Payment terms to be discussed.",
            "footer": f"Generated from Delilclinic Dash Treatment Plan #{plan.id}",
            "discount": float(total_discount_amount),  # Total discount amount (not percentage)
            "partial": 0,
            "line_items": line_items,
            # Custom fields to store Django references
            "custom_value1": f"Django_Plan_{plan.id}",
            "custom_value2": f"Patient_{plan.patient.id}",
            "custom_value3": f"Doctor_{plan.doctor.id}",
            "custom_value4": f"Items_{len(line_items)}"
        }
        
        return data

    def create_in_invoice_ninja(self, data):
        """Create quote in Invoice Ninja"""
        api_url = os.getenv('INVOICE_NINJA_API_URL', 'https://tp.delilclinic.com')
        api_token = os.getenv('INVOICE_NINJA_API_TOKEN')
        
        if not api_token:
            self.stdout.write(self.style.ERROR("⚠️  Invoice Ninja API token not configured"))
            return None, None

        url = f"{api_url}/api/v1/quotes"
        headers = {
            'X-API-TOKEN': api_token,
            'X-Requested-With': 'XMLHttpRequest',
            'Content-Type': 'application/json',
        }

        try:
            response = requests.post(url, json=data, headers=headers, timeout=30)
            self.stdout.write(f"[CREATE RESPONSE {response.status_code}]\n{response.text[:500]}...")
            
            if response.status_code == 200:
                result = response.json()
                if 'data' in result and 'id' in result['data']:
                    quote_id = result['data']['id']
                    self.stdout.write(f"✅ Quote created successfully with ID: {quote_id}")
                    return quote_id
                else:
                    self.stdout.write(f"⚠️  Unexpected response: {result}")
                    return None
            else:
                self.stdout.write(f"❌ API error: {response.status_code} - {response.text}")
                return None
                
        except requests.exceptions.RequestException as e:
            self.stdout.write(f"❌ Request failed: {str(e)}")
            return None

    def update_in_invoice_ninja(self, data, ninja_quote_id):
        """Update existing quote in Invoice Ninja"""
        api_url = os.getenv('INVOICE_NINJA_API_URL', 'https://tp.delilclinic.com')
        api_token = os.getenv('INVOICE_NINJA_API_TOKEN')
        
        if not api_token:
            self.stdout.write(self.style.ERROR("⚠️  Invoice Ninja API token not configured"))
            return None

        url = f"{api_url}/api/v1/quotes/{ninja_quote_id}"
        headers = {
            'X-API-TOKEN': api_token,
            'X-Requested-With': 'XMLHttpRequest',
            'Content-Type': 'application/json',
        }

        try:
            response = requests.put(url, json=data, headers=headers, timeout=30)
            self.stdout.write(f"[UPDATE RESPONSE {response.status_code}]\n{response.text[:500]}...")
            
            if response.status_code == 200:
                result = response.json()
                if 'data' in result and 'id' in result['data']:
                    quote_id = result['data']['id']
                    self.stdout.write(f"✅ Quote updated successfully")
                    return quote_id
                else:
                    self.stdout.write(f"⚠️  Unexpected response: {result}")
                    return ninja_quote_id  # Return the original ID
            else:
                self.stdout.write(f"❌ API error: {response.status_code} - {response.text}")
                return None
                
        except requests.exceptions.RequestException as e:
            self.stdout.write(f"❌ Request failed: {str(e)}")
            return None
