#!/usr/bin/env python
"""
Django Management Command: sync_products_to_invoice_ninja
Syncs TreatmentProduct models from Django to Invoice Ninja as products.
"""

from django.core.management.base import BaseCommand
from django.utils import timezone
from apps.models import TreatmentProduct
import requests
import json
import os
import time

class Command(BaseCommand):
    help = 'Sync TreatmentProduct models to Invoice Ninja as products'

    def add_arguments(self, parser):
        parser.add_argument('--count', type=int, default=10, help='Number of products to sync per run (default 10)')
        parser.add_argument('--dry-run', action='store_true', help='Print only, do not post or update')
        parser.add_argument('--force-update', action='store_true', help='Update existing products in Invoice Ninja')
        parser.add_argument('--product-id', type=int, help='Sync specific product by ID')

    def handle(self, *args, **options):
        count = options['count']
        dry_run = options['dry_run']
        force_update = options['force_update']
        product_id = options['product_id']

        self.stdout.write(f"\n🚀 Product Sync to Invoice Ninja")
        self.stdout.write("="*60)

        # Filter products to sync
        if product_id:
            products = TreatmentProduct.objects.filter(id=product_id, is_active=True)
            if not products.exists():
                self.stdout.write(self.style.ERROR(f"❌ Product with ID {product_id} not found or inactive"))
                return
        else:
            # Get products that haven't been synced yet, or need updating if force_update is True
            if force_update:
                products = TreatmentProduct.objects.filter(is_active=True)[:count]
            else:
                products = TreatmentProduct.objects.filter(
                    is_active=True,
                    invoiceninja_product_id__isnull=True
                )[:count]

        if not products.exists():
            self.stdout.write("✅ No products pending sync.")
            return

        self.stdout.write(f"📦 Found {products.count()} products to sync")
        self.stdout.write("-" * 60)

        success_count = 0
        error_count = 0

        for idx, product in enumerate(products, 1):
            self.stdout.write(f"\n[{idx}/{products.count()}] Processing: {product.name} (ID: {product.id})")
            
            # Check if product already exists in Invoice Ninja
            if hasattr(product, 'invoiceninja_product_id') and product.invoiceninja_product_id and not force_update:
                self.stdout.write(f"⏭️  Product already synced (Invoice Ninja ID: {product.invoiceninja_product_id})")
                continue

            data = self.build_product_data(product)
            self.stdout.write("[DATA TO POST]\n" + json.dumps(data, indent=2, default=str))

            if dry_run:
                self.stdout.write("[DRY RUN] Skipping API POST.")
                continue

            # Determine if we should create or update
            if hasattr(product, 'invoiceninja_product_id') and product.invoiceninja_product_id and force_update:
                ninja_product_id = self.update_in_invoice_ninja(data, product.invoiceninja_product_id)
                action = "updated"
            else:
                ninja_product_id = self.create_in_invoice_ninja(data)
                action = "created"

            if ninja_product_id:
                # Add the field to the model if it doesn't exist
                if not hasattr(product, 'invoiceninja_product_id'):
                    self.stdout.write("⚠️  Adding invoiceninja_product_id field to TreatmentProduct model...")
                    # Note: You'll need to add this field to your model and run migrations
                
                # Save the Invoice Ninja product ID back to our model
                try:
                    product.invoiceninja_product_id = ninja_product_id
                    product.invoiceninja_sync_status = 'synced'
                    product.invoiceninja_last_sync_attempt = timezone.now()
                    product.save(update_fields=[
                        'invoiceninja_product_id',
                        'invoiceninja_sync_status', 
                        'invoiceninja_last_sync_attempt'
                    ])
                    self.stdout.write(self.style.SUCCESS(f"✅ Product {action}! Invoice Ninja ID: {ninja_product_id}"))
                    success_count += 1
                except Exception as e:
                    self.stdout.write(self.style.WARNING(f"⚠️  Product {action} in Invoice Ninja but failed to update local record: {str(e)}"))
                    success_count += 1
            else:
                self.stdout.write(self.style.ERROR(f"❌ Failed to {action.split('d')[0]} product in Invoice Ninja"))
                error_count += 1

            # Add a small delay to avoid overwhelming the API
            time.sleep(0.5)

        self.stdout.write(f"\n🎯 Sync Summary:")
        self.stdout.write(f"✅ Successful: {success_count}")
        self.stdout.write(f"❌ Errors: {error_count}")
        self.stdout.write(f"📦 Total processed: {success_count + error_count}")

    def build_product_data(self, product):
        """Build Invoice Ninja product data from TreatmentProduct model"""
        # Create a unique product key using slug or name
        product_key = product.slug or product.name.replace(' ', '_').upper()
        
        # Map category to a simple string for notes
        category_info = f"Category: {product.category}"
        if product.country_of_origin:
            category_info += f" | Origin: {product.country_of_origin}"
        
        # Build description from product data
        notes_parts = []
        if product.description:
            notes_parts.append(product.description)
        notes_parts.append(category_info)
        notes = " | ".join(notes_parts)

        data = {
            "product_key": product_key[:50],  # Limit length
            "notes": notes[:1000],  # Limit description length
            "cost": float(product.price) if product.price else 0,
            "price": float(product.price) if product.price else 0,
            "quantity": 1,  # Default quantity
            "tax_name1": "",
            "tax_rate1": 0,
            "tax_name2": "",
            "tax_rate2": 0,
            "tax_name3": "",
            "tax_rate3": 0,
            "custom_value1": product.category,  # Store category
            "custom_value2": str(product.country_of_origin) if product.country_of_origin else "",
            "custom_value3": str(product.max_discount_percentage),  # Store max discount
            "custom_value4": f"Django_ID_{product.id}",  # Store original Django ID for reference
            "in_stock_quantity": 1,  # Assume in stock
            "stock_notification": False,
            "stock_notification_threshold": 0,
            "max_quantity": 0,  # No limit
            "product_image": "",  # TODO: Handle image upload if needed
        }
        
        return data

    def create_in_invoice_ninja(self, data):
        """Create product in Invoice Ninja"""
        api_url = os.getenv('INVOICE_NINJA_API_URL', 'https://tp.delilclinic.com')
        api_token = os.getenv('INVOICE_NINJA_API_TOKEN')
        
        if not api_token:
            self.stdout.write(self.style.ERROR("⚠️  Invoice Ninja API token not configured"))
            return None

        url = f"{api_url}/api/v1/products"
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
                    return result['data']['id']
                else:
                    self.stdout.write(f"⚠️  Unexpected response: {result}")
                    return None
            else:
                self.stdout.write(f"❌ API error: {response.status_code} - {response.text}")
                return None
                
        except requests.exceptions.RequestException as e:
            self.stdout.write(f"❌ Request failed: {str(e)}")
            return None

    def update_in_invoice_ninja(self, data, ninja_product_id):
        """Update existing product in Invoice Ninja"""
        api_url = os.getenv('INVOICE_NINJA_API_URL', 'https://tp.delilclinic.com')
        api_token = os.getenv('INVOICE_NINJA_API_TOKEN')
        
        if not api_token:
            self.stdout.write(self.style.ERROR("⚠️  Invoice Ninja API token not configured"))
            return None

        url = f"{api_url}/api/v1/products/{ninja_product_id}"
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
                    return result['data']['id']
                else:
                    self.stdout.write(f"⚠️  Unexpected response: {result}")
                    return ninja_product_id  # Return the original ID
            else:
                self.stdout.write(f"❌ API error: {response.status_code} - {response.text}")
                return None
                
        except requests.exceptions.RequestException as e:
            self.stdout.write(f"❌ Request failed: {str(e)}")
            return None
