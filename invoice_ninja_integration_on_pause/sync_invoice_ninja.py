#!/usr/bin/env python
"""
Django Management Command for Invoice Ninja Integration
This command monitors signup actions and creates Invoice Ninja clients
"""

from django.core.management.base import BaseCommand
from django.contrib.auth import get_user_model
from django.db.models import Q
from datetime import datetime, timedelta
import requests
import json
import os

User = get_user_model()

class Command(BaseCommand):
    help = 'Process Invoice Ninja client creation for new signups'

    def add_arguments(self, parser):
        parser.add_argument(
            '--action',
            type=str,
            choices=['monitor', 'sync_user', 'batch_sync'],
            default='monitor',
            help='Action to perform: monitor (watch for new signups), sync_user (sync specific user), batch_sync (sync multiple users)'
        )
        parser.add_argument(
            '--user-id',
            type=int,
            help='Specific user ID to sync (used with sync_user action)'
        )
        parser.add_argument(
            '--days',
            type=int,
            default=1,
            help='Number of days back to check for new signups (default: 1)'
        )
        parser.add_argument(
            '--dry-run',
            action='store_true',
            help='Show what would be done without actually doing it'
        )

    def handle(self, *args, **options):
        action = options['action']
        
        if action == 'monitor':
            self.monitor_signups(options)
        elif action == 'sync_user':
            self.sync_specific_user(options)
        elif action == 'batch_sync':
            self.batch_sync_users(options)

    def monitor_signups(self, options):
        """Monitor for new signups and create Invoice Ninja clients"""
        days = options['days']
        dry_run = options['dry_run']
        
        self.stdout.write(f"Monitoring signups from last {days} days...")
        
        # Find users who signed up recently and don't have Invoice Ninja client IDs
        cutoff_date = datetime.now() - timedelta(days=days)
        
        new_users = User.objects.filter(
            date_joined__gte=cutoff_date,
            invoiceninja_client_id__isnull=True,
            invoiceninja_sync_status__in=['pending', 'failed']
        ).order_by('-date_joined')
        
        self.stdout.write(f"Found {new_users.count()} users to process")
        
        for user in new_users:
            self.stdout.write(f"Processing user: {user.email} (ID: {user.id})")
            
            if dry_run:
                self.stdout.write(f"  [DRY RUN] Would create Invoice Ninja client for {user.email}")
                continue
            
            success = self.create_invoice_ninja_client(user)
            if success:
                self.stdout.write(self.style.SUCCESS(f"  ✓ Created client for {user.email}"))
            else:
                self.stdout.write(self.style.ERROR(f"  ✗ Failed to create client for {user.email}"))

    def sync_specific_user(self, options):
        """Sync a specific user by ID"""
        user_id = options['user_id']
        dry_run = options['dry_run']
        
        if not user_id:
            self.stdout.write(self.style.ERROR("User ID is required for sync_user action"))
            return
        
        try:
            user = User.objects.get(id=user_id)
            self.stdout.write(f"Syncing user: {user.email} (ID: {user.id})")
            
            if dry_run:
                self.stdout.write(f"[DRY RUN] Would create Invoice Ninja client for {user.email}")
                return
            
            success = self.create_invoice_ninja_client(user)
            if success:
                self.stdout.write(self.style.SUCCESS(f"✓ Successfully synced {user.email}"))
            else:
                self.stdout.write(self.style.ERROR(f"✗ Failed to sync {user.email}"))
                
        except User.DoesNotExist:
            self.stdout.write(self.style.ERROR(f"User with ID {user_id} not found"))

    def batch_sync_users(self, options):
        """Sync multiple users who don't have client IDs"""
        dry_run = options['dry_run']
        
        # Find all users without Invoice Ninja client IDs
        users_to_sync = User.objects.filter(
            Q(invoiceninja_client_id__isnull=True) | Q(invoiceninja_client_id=''),
            invoiceninja_sync_status__in=['pending', 'failed', 'retry']
        ).order_by('-date_joined')
        
        self.stdout.write(f"Found {users_to_sync.count()} users to sync")
        
        success_count = 0
        error_count = 0
        
        for user in users_to_sync:
            self.stdout.write(f"Processing: {user.email}")
            
            if dry_run:
                self.stdout.write(f"  [DRY RUN] Would process {user.email}")
                continue
            
            if self.create_invoice_ninja_client(user):
                success_count += 1
                self.stdout.write(self.style.SUCCESS(f"  ✓ Success"))
            else:
                error_count += 1
                self.stdout.write(self.style.ERROR(f"  ✗ Failed"))
        
        if not dry_run:
            self.stdout.write(f"Batch sync complete: {success_count} success, {error_count} errors")

    def create_invoice_ninja_client(self, user):
        """Create Invoice Ninja client for a user"""
        try:
            # Prepare data in Invoice Ninja format
            client_data = self.format_user_for_invoice_ninja(user)
            
            # Make API call to Invoice Ninja
            client_id = self.call_invoice_ninja_api(client_data)
            
            if client_id:
                # Update user with client ID
                user.invoiceninja_client_id = client_id
                user.invoiceninja_sync_status = 'synced'
                user.invoiceninja_last_sync_attempt = datetime.now()
                user.save()
                return True
            else:
                # Mark as failed
                user.invoiceninja_sync_status = 'failed'
                user.invoiceninja_sync_attempts += 1
                user.invoiceninja_last_sync_attempt = datetime.now()
                user.save()
                return False
                
        except Exception as e:
            self.stdout.write(self.style.ERROR(f"Error creating client for {user.email}: {str(e)}"))
            user.invoiceninja_sync_status = 'failed'
            user.invoiceninja_sync_attempts += 1
            user.invoiceninja_last_sync_attempt = datetime.now()
            user.save()
            return False

    def format_user_for_invoice_ninja(self, user):
        """Format user data exactly as Invoice Ninja expects"""
        
        # Map country codes to Invoice Ninja country IDs
        country_mapping = {
            'US': 840, 'CA': 124, 'GB': 826, 'DE': 276, 'FR': 250,
            'ES': 724, 'IT': 380, 'TR': 792, 'AE': 784, 'SA': 682,
            'AU': 36, 'NZ': 554, 'JP': 392, 'KR': 410, 'CN': 156,
            'IN': 356, 'BR': 76, 'MX': 484, 'AR': 32, 'CL': 152,
            'CO': 170, 'PE': 604, 'NL': 528, 'BE': 56, 'CH': 756,
            'AT': 40, 'SE': 752, 'NO': 578, 'DK': 208, 'FI': 246,
            'IE': 372, 'PT': 620, 'GR': 300, 'PL': 616, 'CZ': 203,
            'HU': 348, 'RO': 642, 'BG': 100, 'HR': 191, 'SI': 705,
            'SK': 703, 'LT': 440, 'LV': 428, 'EE': 233, 'IS': 352,
            'MT': 470, 'CY': 196, 'LU': 442, 'IL': 376, 'EG': 818,
            'ZA': 710, 'NG': 566, 'KE': 404, 'GH': 288, 'MA': 504,
            'TN': 788, 'DZ': 12, 'LY': 434, 'SD': 729, 'ET': 231,
            'UG': 800, 'TZ': 834, 'ZW': 716, 'BW': 72, 'ZM': 894,
            'MW': 454, 'MZ': 508, 'AO': 24, 'NA': 516, 'SZ': 748,
            'LS': 426, 'MG': 450, 'MU': 480, 'SC': 690, 'RE': 638,
            'YT': 175, 'KM': 174, 'DJ': 262, 'SO': 706, 'ER': 232,
        }
        
        country_id = country_mapping.get(str(user.nationality), 840)  # Default to US
        
        # Format data exactly as Invoice Ninja expects
        invoice_ninja_data = {
            "name": f"{user.first_name} {user.last_name}".strip() or user.username,
            "email": user.email,
            "phone": user.phone_number or "",
            "website": "",
            "address1": "",  # You can add address fields if available
            "address2": "",
            "city": "",
            "state": "",
            "postal_code": "",
            "country_id": country_id,
            "custom_value1": str(user.id),  # Django user ID for reference
            "custom_value2": str(user.nationality) if user.nationality else "",
            "custom_value3": str(user.date_of_birth) if user.date_of_birth else "",
            "custom_value4": user.referral_code or "",
            "public_notes": f"Medical tourism patient from Django (User ID: {user.id})",
            "private_notes": f"Created: {user.date_joined}, Phone: {user.phone_number}",
            "currency_id": 1,  # Default currency (usually USD)
        }
        
        # Remove empty values to keep the payload clean
        return {k: v for k, v in invoice_ninja_data.items() if v}

    def call_invoice_ninja_api(self, client_data):
        """Make the actual API call to Invoice Ninja"""
        api_url = os.getenv('INVOICE_NINJA_API_URL', 'https://invoicing.co')
        api_token = os.getenv('INVOICE_NINJA_API_TOKEN')
        
        if not api_token or api_token == 'your-test-api-token-here':
            self.stdout.write(self.style.ERROR("Invoice Ninja API token not configured"))
            return None
        
        url = f"{api_url}/api/v1/clients"
        headers = {
            'X-API-TOKEN': api_token,
            'X-Requested-With': 'XMLHttpRequest',
            'Content-Type': 'application/json',
        }
        
        try:
            self.stdout.write(f"Calling Invoice Ninja API: {url}")
            self.stdout.write(f"Data: {json.dumps(client_data, indent=2)}")
            
            response = requests.post(url, json=client_data, headers=headers, timeout=30)
            
            if response.status_code == 200:
                result = response.json()
                if 'data' in result and 'id' in result['data']:
                    client_id = result['data']['id']
                    self.stdout.write(f"Invoice Ninja client created: {client_id}")
                    return client_id
                else:
                    self.stdout.write(self.style.ERROR(f"Unexpected response format: {result}"))
                    return None
            else:
                self.stdout.write(self.style.ERROR(f"API call failed: {response.status_code} - {response.text}"))
                return None
                
        except requests.exceptions.RequestException as e:
            self.stdout.write(self.style.ERROR(f"API request failed: {str(e)}"))
            return None
