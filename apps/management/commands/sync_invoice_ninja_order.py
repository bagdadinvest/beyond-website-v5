#!/usr/bin/env python
"""
Django Management Command: sync_invoice_ninja_order
Syncs N users as Invoice Ninja clients, using specific columns, one by one.
"""

from django.core.management.base import BaseCommand
from django.contrib.auth import get_user_model
from django.db.models import Q
from django.utils import timezone
import requests
import json
import os

User = get_user_model()

class Command(BaseCommand):
    help = 'Sync N users to Invoice Ninja using specific columns (order_columns)'

    def add_arguments(self, parser):
        parser.add_argument('--count', type=int, default=5, help='Number of users to sync per run (default 5)')
        parser.add_argument('--dry-run', action='store_true', help='Print only, do not post or update')

    def handle(self, *args, **options):
        count = options['count']
        dry_run = options['dry_run']

        self.stdout.write(f"\n🚀 Invoice Ninja Batch Sync (order_columns) - {count} users per run")
        self.stdout.write("="*60)

        users = User.objects.filter(
            Q(invoiceninja_client_id__isnull=True) | Q(invoiceninja_client_id='')
        ).order_by('date_joined')[:count]

        if not users:
            self.stdout.write("✅ No users pending sync.")
            return

        for idx, user in enumerate(users, 1):
            self.stdout.write(f"\n[{idx}/{count}] Preparing user: {user.email} (ID: {user.id})")

            data = self.build_client_data(user)
            self.stdout.write("[DATA TO POST]\n" + json.dumps(data, indent=2, default=str))

            if dry_run:
                self.stdout.write("[DRY RUN] Skipping API POST.")
                continue

            client_id = self.send_to_invoice_ninja(data)
            if client_id:
                user.invoiceninja_client_id = client_id
                user.invoiceninja_sync_status = 'synced'
                user.invoiceninja_last_sync_attempt = timezone.now()
                user.save(update_fields=[
                    'invoiceninja_client_id',
                    'invoiceninja_sync_status',
                    'invoiceninja_last_sync_attempt'
                ])
                self.stdout.write(self.style.SUCCESS(f"✅ Client created! ID: {client_id}"))
            else:
                self.stdout.write(self.style.ERROR("❌ Failed to create client or no ID returned."))

    def build_client_data(self, user):
        # Map country, language, currency as needed
        country_map = {
            'US': 840, 'CA': 124, 'GB': 826, 'DE': 276, 'FR': 250, 'ES': 724,
            'IT': 380, 'TR': 792, 'AE': 784, 'SA': 682, 'AU': 36, 'JP': 392,
            'BR': 76, 'MX': 484, 'NL': 528, 'CH': 756, 'SE': 752, 'NO': 578,
        }
        currency_map = {
            'USD': 1, 'EUR': 3, 'GBP': 2, 'TRY': 46, 'AED': 131, 'SAR': 137, 'JPY': 27,
            'BRL': 7, 'MXN': 16, 'CHF': 4, 'SEK': 11, 'NOK': 15,
        }
        language_map = {
            'en': 1, 'fr': 2, 'de': 3, 'tr': 15, 'ar': 11, 'es': 4,
        }

        # --- ORDER COLUMNS ---
        name = f"{user.first_name} {user.last_name}".strip() or user.username or ''
        contact_email = user.email or ''
        contact_phone = getattr(user, "phone_number", "") or ""
        language = language_map.get(getattr(user, "language", "en"), 1)
        country = country_map.get(str(getattr(user, "nationality", "")), 840)
        referral_code = getattr(user, "referral_code", "") or ""
        currency = currency_map.get(getattr(user, "currency", "USD"), 1)
        website = getattr(user, "website", "") or ""
        id_number = ""  # Leave blank for now
        date_created = user.date_joined.strftime('%Y-%m-%d')
        balance = ""
        paid_to_date = ""
        last_login_at = user.last_login.strftime('%Y-%m-%d %H:%M') if user.last_login else ""
        public_notes = getattr(user, "public_notes", "") or ""

        data = {
            "name": name,
            "contacts": [
                {
                    "email": contact_email,
                    "phone": contact_phone,
                    "first_name": user.first_name or "",
                    "last_name": user.last_name or "",
                    "custom_value1": referral_code
                }
            ],
            "country_id": country,
            "language_id": language,
            "currency_id": currency,
            "website": website,
            "id_number": id_number,
            "date_created": date_created,
            "balance": balance,
            "paid_to_date": paid_to_date,
            "last_login": last_login_at,
            "public_notes": public_notes,
            # Additional fields can be added as needed
        }
        return {k: v for k, v in data.items() if v or isinstance(v, (int, float, list, dict))}

    def send_to_invoice_ninja(self, data):
        api_url = os.getenv('INVOICE_NINJA_API_URL', 'https://tp.delilclinic.com')
        api_token = os.getenv('INVOICE_NINJA_API_TOKEN')
        if not api_token or api_token == 'your-fake-api-token-here':
            self.stdout.write(self.style.ERROR("⚠️  Invoice Ninja API token not configured"))
            return None

        url = f"{api_url}/api/v1/clients"
        headers = {
            'X-API-TOKEN': api_token,
            'X-Requested-With': 'XMLHttpRequest',
            'Content-Type': 'application/json',
        }

        try:
            response = requests.post(url, json=data, headers=headers, timeout=30)
            self.stdout.write(f"[RESPONSE {response.status_code}]\n{response.text}")
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
