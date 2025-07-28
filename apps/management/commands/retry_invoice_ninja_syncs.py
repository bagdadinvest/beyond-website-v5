"""
Django Management Command: Retry Failed Invoice Ninja Syncs

This command identifies users whose Invoice Ninja synchronization has failed
and attempts to retry the sync operation.

Usage:
    python manage.py retry_invoice_ninja_syncs
    python manage.py retry_invoice_ninja_syncs --max-attempts 5
    python manage.py retry_invoice_ninja_syncs --user-id 123
    python manage.py retry_invoice_ninja_syncs --dry-run

Author: Django-Invoice Ninja Integration Team
Created: 2025-01-25
"""

from django.core.management.base import BaseCommand, CommandError
from django.contrib.auth import get_user_model
from django.conf import settings
from django.utils import timezone
from apps.invoice_ninja_utils import SyncStatusManager, process_user_for_invoice_ninja_sync

User = get_user_model()


class Command(BaseCommand):
    help = 'Retry failed Invoice Ninja synchronizations for users'

    def add_arguments(self, parser):
        parser.add_argument(
            '--user-id',
            type=int,
            help='Retry sync for a specific user ID',
        )
        parser.add_argument(
            '--max-attempts',
            type=int,
            default=getattr(settings, 'INVOICE_NINJA_MAX_SYNC_ATTEMPTS', 3),
            help='Maximum number of sync attempts allowed (default: 3)',
        )
        parser.add_argument(
            '--dry-run',
            action='store_true',
            help='Show what would be done without actually performing the sync',
        )
        parser.add_argument(
            '--force',
            action='store_true',
            help='Force retry even for users who have exceeded max attempts',
        )

    def handle(self, *args, **options):
        self.stdout.write(
            self.style.SUCCESS('Starting Invoice Ninja sync retry process...')
        )

        user_id = options.get('user_id')
        max_attempts = options.get('max_attempts')
        dry_run = options.get('dry_run')
        force = options.get('force')

        if user_id:
            # Retry sync for a specific user
            try:
                user = User.objects.get(id=user_id)
                self._retry_user_sync(user, max_attempts, dry_run, force)
            except User.DoesNotExist:
                raise CommandError(f'User with ID {user_id} does not exist')
        else:
            # Retry sync for all eligible users
            self._retry_bulk_sync(max_attempts, dry_run, force)

        self.stdout.write(
            self.style.SUCCESS('Invoice Ninja sync retry process completed.')
        )

    def _retry_user_sync(self, user, max_attempts, dry_run, force):
        """Retry sync for a single user"""
        
        # Check if user needs sync
        if user.invoiceninja_sync_status == 'synced' and user.invoiceninja_client_id:
            self.stdout.write(
                self.style.WARNING(f'User {user.id} ({user.username}) is already synced.')
            )
            return

        # Check max attempts
        if not force and user.invoiceninja_sync_attempts >= max_attempts:
            self.stdout.write(
                self.style.WARNING(
                    f'User {user.id} ({user.username}) has reached max attempts ({user.invoiceninja_sync_attempts}/{max_attempts}). '
                    f'Use --force to override.'
                )
            )
            return

        self.stdout.write(f'Processing user {user.id} ({user.username})...')
        
        if dry_run:
            self.stdout.write(
                self.style.WARNING(
                    f'[DRY RUN] Would retry sync for user {user.id} '
                    f'(current attempts: {user.invoiceninja_sync_attempts})'
                )
            )
            return

        # Attempt sync
        try:
            success = process_user_for_invoice_ninja_sync(user)
            if success:
                self.stdout.write(
                    self.style.SUCCESS(
                        f'Successfully initiated retry sync for user {user.id}'
                    )
                )
            else:
                self.stdout.write(
                    self.style.ERROR(
                        f'Failed to initiate retry sync for user {user.id}'
                    )
                )
        except Exception as e:
            self.stdout.write(
                self.style.ERROR(
                    f'Error retrying sync for user {user.id}: {str(e)}'
                )
            )

    def _retry_bulk_sync(self, max_attempts, dry_run, force):
        """Retry sync for all eligible users"""
        
        if force:
            # Get all users that need sync, regardless of attempts
            users = User.objects.filter(
                invoiceninja_sync_status__in=['pending', 'retry', 'failed']
            ).exclude(
                invoiceninja_sync_status='synced',
                invoiceninja_client_id__isnull=False
            )
        else:
            # Get users that haven't exceeded max attempts
            users = SyncStatusManager.get_users_pending_sync()

        total_users = users.count()
        
        if total_users == 0:
            self.stdout.write(
                self.style.WARNING('No users found that need Invoice Ninja synchronization.')
            )
            return

        self.stdout.write(f'Found {total_users} users that need synchronization.')

        if dry_run:
            self.stdout.write(self.style.WARNING('[DRY RUN] Would process the following users:'))
            for user in users:
                self.stdout.write(
                    f'  - User {user.id} ({user.username}) - Status: {user.invoiceninja_sync_status}, '
                    f'Attempts: {user.invoiceninja_sync_attempts}'
                )
            return

        # Process users
        success_count = 0
        error_count = 0

        for user in users:
            try:
                self.stdout.write(f'Processing user {user.id} ({user.username})...')
                
                success = process_user_for_invoice_ninja_sync(user)
                if success:
                    success_count += 1
                    self.stdout.write(
                        self.style.SUCCESS(f'  ✓ Successfully initiated sync for user {user.id}')
                    )
                else:
                    error_count += 1
                    self.stdout.write(
                        self.style.ERROR(f'  ✗ Failed to initiate sync for user {user.id}')
                    )
                    
            except Exception as e:
                error_count += 1
                self.stdout.write(
                    self.style.ERROR(f'  ✗ Error processing user {user.id}: {str(e)}')
                )

        # Summary
        self.stdout.write(
            self.style.SUCCESS(
                f'\nBulk sync retry completed: {success_count} successful, {error_count} errors'
            )
        )
