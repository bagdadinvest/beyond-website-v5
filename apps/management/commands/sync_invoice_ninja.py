#!/usr/bin/env python
"""
Django Management Command: sync_invoice_ninja
Simple command to sync users with Invoice Ninja based on signup actions
"""

from django.core.management.base import BaseCommand
from django.contrib.auth import get_user_model
from django.db.models import Q
from datetime import timedelta
from django.utils import timezone
import requests
import json
import os

User = get_user_model()

class Command(BaseCommand):
    help = 'Sync users with Invoice Ninja - create client IDs for new signups'

    def add_arguments(self, parser):
        parser.add_argument(
            '--action',
            type=str,
            choices=['monitor', 'sync_user', 'batch_sync'],
            default='monitor',
            help='monitor: watch new signups | sync_user: sync specific user | batch_sync: sync all pending'
        )
        parser.add_argument('--user-id', type=int, help='User ID to sync (for sync_user action)')
        parser.add_argument('--days', type=int, default=1, help='Days back to check for signups (default: 1)')
        parser.add_argument('--dry-run', action='store_true', help='Show what would be done without doing it')

    def handle(self, *args, **options):
        self.stdout.write("🚀 Invoice Ninja Sync Command")
        self.stdout.write("="*50)
        
        action = options['action']
        
        if action == 'monitor':
            self.monitor_new_signups(options)
        elif action == 'sync_user':
            self.sync_single_user(options)
        elif action == 'batch_sync':
            self.batch_sync_all(options)

    def monitor_new_signups(self, options):
        """Monitor recent signups and create Invoice Ninja clients"""
        days = options['days']
        dry_run = options['dry_run']
        
        self.stdout.write(f"📅 Checking signups from last {days} days...")
        
        cutoff_date = timezone.now() - timedelta(days=days)

        
        # Find users who need Invoice Ninja client IDs
        new_users = User.objects.filter(
            date_joined__gte=cutoff_date,
            invoiceninja_client_id__isnull=True
        ).order_by('-date_joined')
        
        self.stdout.write(f"👥 Found {new_users.count()} users to process")
        
        if new_users.count() == 0:
            self.stdout.write("✅ No new users to sync")
            return
        
        for user in new_users:
            self.stdout.write(f"\n👤 Processing: {user.email} (ID: {user.id})")
            
            if dry_run:
                self.stdout.write("   [DRY RUN] Would create Invoice Ninja client")
                data = self.format_user_data(user)
                self.stdout.write(f"   Data: {json.dumps(data, indent=6)}")
                continue
            
            if self.sync_user_to_invoice_ninja(user):
                self.stdout.write(self.style.SUCCESS("   ✅ Success"))
            else:
                self.stdout.write(self.style.ERROR("   ❌ Failed"))

    def sync_single_user(self, options):
        """Sync a specific user by ID"""
        user_id = options['user_id']
        
        if not user_id:
            self.stdout.write(self.style.ERROR("❌ User ID required for sync_user action"))
            return
        
        try:
            user = User.objects.get(id=user_id)
            self.stdout.write(f"👤 Syncing user: {user.email}")
            
            if options['dry_run']:
                data = self.format_user_data(user)
                self.stdout.write("📋 Would send to Invoice Ninja:")
                self.stdout.write(json.dumps(data, indent=2))
                return
            
            if self.sync_user_to_invoice_ninja(user):
                self.stdout.write(self.style.SUCCESS("✅ User synced successfully"))
            else:
                self.stdout.write(self.style.ERROR("❌ Sync failed"))
                
        except User.DoesNotExist:
            self.stdout.write(self.style.ERROR(f"❌ User {user_id} not found"))

    def batch_sync_all(self, options):
        """Sync all users who don't have client IDs"""
        dry_run = options['dry_run']
        
        users_without_clients = User.objects.filter(
            Q(invoiceninja_client_id__isnull=True) | Q(invoiceninja_client_id='')
        ).order_by('-date_joined')
        
        total = users_without_clients.count()
        self.stdout.write(f"📊 Found {total} users without Invoice Ninja client IDs")
        
        if total == 0:
            self.stdout.write("✅ All users already synced")
            return
        
        success = 0
        errors = 0
        
        for i, user in enumerate(users_without_clients, 1):
            self.stdout.write(f"\n[{i}/{total}] {user.email}")
            
            if dry_run:
                self.stdout.write("   [DRY RUN] Would sync")
                continue
            
            if self.sync_user_to_invoice_ninja(user):
                success += 1
                self.stdout.write("   ✅")
            else:
                errors += 1
                self.stdout.write("   ❌")
        
        if not dry_run:
            self.stdout.write(f"\n📈 Results: {success} success, {errors} errors")

    def sync_user_to_invoice_ninja(self, user):
        """Main sync function - create Invoice Ninja client for user"""
        try:
            # Format data for Invoice Ninja
            client_data = self.format_user_data(user)
            
            # Call Invoice Ninja API
            client_id = self.create_invoice_ninja_client(client_data)
            
            if client_id:
                # Update user with new client ID
                user.invoiceninja_client_id = client_id
                user.invoiceninja_sync_status = 'synced'
                user.invoiceninja_last_sync_attempt = timezone.now()
                user.save()
                self.stdout.write(f"   💾 Client ID saved: {client_id}")
                return True
            else:
                # Mark as failed
                user.invoiceninja_sync_status = 'failed'
                user.invoiceninja_sync_attempts = (user.invoiceninja_sync_attempts or 0) + 1
                user.invoiceninja_last_sync_attempt =  timezone.now()
                user.save()
                return False
                
        except Exception as e:
            self.stdout.write(self.style.ERROR(f"   💥 Error: {str(e)}"))
            return False

    def format_user_data(self, user):
        """Format user data exactly as Invoice Ninja expects it"""
        
        # Map countries to Invoice Ninja country IDs
        country_map = {
            'US': 840, 'CA': 124, 'GB': 826, 'DE': 276, 'FR': 250, 'ES': 724,
            'IT': 380, 'TR': 792, 'AE': 784, 'SA': 682, 'AU': 36, 'JP': 392,
            'BR': 76, 'MX': 484, 'NL': 528, 'CH': 756, 'SE': 752, 'NO': 578,
        }
        
        country_id = country_map.get(str(user.nationality), 840)  # Default to US
        
        # Build the payload exactly as Invoice Ninja expects
        data = {
            "name": f"{user.first_name} {user.last_name}".strip() or user.username,
            "email": user.email,
            "phone": user.phone_number or "",
            "country_id": country_id,
            "custom_value1": str(user.id),  # Store Django user ID
            "custom_value2": str(user.nationality) if user.nationality else "",
            "custom_value3": str(user.date_of_birth) if user.date_of_birth else "",
            "custom_value4": user.referral_code or "",
            "public_notes": f"Medical tourism patient (Django ID: {user.id})",
            "private_notes": f"Signup: {user.date_joined.strftime('%Y-%m-%d')}"
        }
        
        # Remove empty values
        return {k: v for k, v in data.items() if v}

    def create_invoice_ninja_client(self, client_data):
        """Call Invoice Ninja API to create client"""
        api_url = os.getenv('INVOICE_NINJA_API_URL', 'https://tp.delilclinic.com')
        api_token = os.getenv('INVOICE_NINJA_API_TOKEN')
        
        if not api_token or api_token == 'jWfHBOpDXAqQ8tZo4WO9LcPEQ9V0h7asN4IK2rAYIB3JWGlF4HuJjCuCvRK1IVm1':
            self.stdout.write(self.style.ERROR("   ⚠️  Invoice Ninja API token not configured"))
            return None
        
        url = f"{api_url}/api/v1/clients"
        headers = {
            'X-API-TOKEN': api_token,
            'X-Requested-With': 'XMLHttpRequest',
            'Content-Type': 'application/json',
        }
        
        try:
            response = requests.post(url, json=client_data, headers=headers, timeout=30)
            
            if response.status_code == 200:
                result = response.json()
                if 'data' in result and 'id' in result['data']:
                    return result['data']['id']
                else:
                    self.stdout.write(f"   ⚠️  Unexpected response: {result}")
                    return None
            else:
                self.stdout.write(f"   ❌ API error: {response.status_code} - {response.text}")
                return None
                
        except requests.exceptions.RequestException as e:
            self.stdout.write(f"   ❌ Request failed: {str(e)}")
            return None
