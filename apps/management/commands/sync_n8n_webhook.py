#!/usr/bin/env python
"""
Django Management Command: sync_n8n_webhook
Syncs exactly 5 unsynced users (or any custom batch size) by POSTing their data to n8n webhook.
"""

from django.core.management.base import BaseCommand
from django.contrib.auth import get_user_model
from django.db.models import Q
from datetime import timedelta
from django.utils import timezone
import requests
import json

User = get_user_model()

WEBHOOK_URL = "https://n8n8.beyond-board.me/webhook-test/1b169ad2-58fb-423e-9802-4b098e94ad56"

class Command(BaseCommand):
    help = 'Send next 5 unsynced users to n8n webhook (manual, 1 batch per run)'

    def add_arguments(self, parser):
        parser.add_argument('--dry-run', action='store_true', help='Show actions without sending to webhook')
        parser.add_argument('--count', type=int, default=5, help='How many users to process per run (default 5)')

    def handle(self, *args, **options):
        batch_size = options['count']
        self.stdout.write(f"\n🚀 Batch Sync: n8n Webhook ({batch_size} users per run)")
        self.stdout.write("="*60)

        # Find next N users needing sync
        users = User.objects.filter(
            Q(invoiceninja_client_id__isnull=True) | Q(invoiceninja_client_id='')
        ).order_by('date_joined')[:batch_size]

        count = users.count()
        if count == 0:
            self.stdout.write("✅ No users pending sync.")
            return

        for idx, user in enumerate(users, 1):
            self.stdout.write(f"\n[{idx}/{batch_size}] Processing user: {user.email} (ID: {user.id})")

            data = self.format_user_data(user)

            if options['dry_run']:
                self.stdout.write("[DRY RUN] Would POST to n8n webhook:")
                self.stdout.write(json.dumps(data, indent=4))
                continue

            success = self.send_to_webhook(user, data)
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

    def send_to_webhook(self, user, data):
        url = WEBHOOK_URL
        headers = {
            'Content-Type': 'application/json',
        }

        try:
            response = requests.post(url, json=data, headers=headers, timeout=30)
            if response.status_code in (200, 201, 202):
                user.invoiceninja_sync_status = 'webhook_synced'
                user.invoiceninja_last_sync_attempt = timezone.now()
                user.save(update_fields=['invoiceninja_sync_status', 'invoiceninja_last_sync_attempt'])
                self.stdout.write(f"   🌍 Webhook POST succeeded. Response: {response.text[:120]}...")
                return True
            else:
                self.stdout.write(f"   ❌ Webhook API error: {response.status_code} - {response.text}")
                return False
        except requests.exceptions.RequestException as e:
            self.stdout.write(f"   ❌ Request failed: {str(e)}")
            return False
