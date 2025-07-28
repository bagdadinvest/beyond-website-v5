#!/usr/bin/env python
"""
Django Management Command: sync_invoice_ninja_batch
Syncs exactly 5 unsynced users with Invoice Ninja (one at a time, interactive)
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
    help = 'Sync the next 5 unsynced users with Invoice Ninja (no automation, manual batch)'

    def add_arguments(self, parser):
        parser.add_argument('--dry-run', action='store_true', help='Show actions without sending to Invoice Ninja')

    def handle(self, *args, **options):
        self.stdout.write("\n🚀 Batch Sync: Invoice Ninja (5 users at a time)")
        self.stdout.write("="*60)

        # Find next 5 users needing sync
        users = User.objects.filter(
            Q(invoiceninja_client_id__isnull=True) | Q(invoiceninja_client_id='')
        ).order_by('date_joined')[:1]

        count = users.count()
        if count == 0:
            self.stdout.write("✅ No users pending sync.")
            return

        for idx, user in enumerate(users, 1):
            self.stdout.write(f"\n[{idx}/5] Processing user: {user.email} (ID: {user.id})")

            data = self.format_user_data(user)

            if options['dry_run']:
                self.stdout.write("[DRY RUN] Would POST to Invoice Ninja:")
                self.stdout.write(json.dumps(data, indent=4))
                continue

            success = self.sync_user_to_invoice_ninja(user, data)
            if success:
                self.stdout.write(self.style.SUCCESS("   ✅ Success"))
            else:
                self.stdout.write(self.style.ERROR("   ❌ Failed"))

        self.stdout.write("\nBatch complete.\n")

    def format_user_data(self, user):
        country_map = {
            'US': 840, 'CA': 124, 'GB': 826, 'DE': 276, 'FR': 250, 'ES': 724,
            'IT': 380, 'TR': 792, 'AE': 784, 'SA': 682, 'AU': 36, 'JP': 392,
            'BR': 76, 'MX': 484, 'NL': 528, 'CH': 756, 'SE': 752, 'NO': 578,
        }
        country_id = country_map.get(str(user.nationality), 840)
        data = {
            "name": f"{user.first_name} {user.last_name}".strip() or user.username,
            "email": user.email,
            "phone": user.phone_number or "",
            "country_id": country_id,
            "custom_value1": str(user.id),
            "custom_value2": str(user.nationality) if user.nationality else "",
            "custom_value3": str(user.date_of_birth) if user.date_of_birth else "",
            "custom_value4": user.referral_code or "",
            "public_notes": f"Medical tourism patient (Django ID: {user.id})",
            "private_notes": f"Signup: {user.date_joined.strftime('%Y-%m-%d')}"
        }
        return {k: v for k, v in data.items() if v}

    def sync_user_to_invoice_ninja(self, user, data):
        api_url = os.getenv('INVOICE_NINJA_API_URL', 'https://tp.delilclinic.com')
        api_token = os.getenv('INVOICE_NINJA_API_TOKEN')

        if not api_token or api_token == 'your-fake-api-token-here':
            self.stdout.write(self.style.ERROR("   ⚠️  Invoice Ninja API token not configured"))
            return False

        url = f"{api_url}/api/v1/clients"
        headers = {
            'X-API-TOKEN': api_token,
            'X-Requested-With': 'XMLHttpRequest',
            'Content-Type': 'application/json',
        }

        try:
            response = requests.post(url, json=data, headers=headers, timeout=30)
            if response.status_code == 200:
                result = response.json()
                if 'data' in result and 'id' in result['data']:
                    user.invoiceninja_client_id = result['data']['id']
                    user.invoiceninja_sync_status = 'synced'
                    user.invoiceninja_last_sync_attempt = timezone.now()
                    user.save(update_fields=[
                        'invoiceninja_client_id',
                        'invoiceninja_sync_status',
                        'invoiceninja_last_sync_attempt'
                    ])
                    self.stdout.write(f"   💾 Client ID saved: {user.invoiceninja_client_id}")
                    return True
                else:
                    self.stdout.write(f"   ⚠️  Unexpected response: {result}")
                    return False
            else:
                self.stdout.write(f"   ❌ API error: {response.status_code} - {response.text}")
                return False
        except requests.exceptions.RequestException as e:
            self.stdout.write(f"   ❌ Request failed: {str(e)}")
            return False
