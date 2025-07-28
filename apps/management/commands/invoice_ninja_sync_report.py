"""
Django Management Command: Invoice Ninja Sync Status Report

This command generates a comprehensive report of Invoice Ninja synchronization
status for all users in the system.

Usage:
    python manage.py invoice_ninja_sync_report
    python manage.py invoice_ninja_sync_report --export-csv /path/to/report.csv
    python manage.py invoice_ninja_sync_report --status failed
    python manage.py invoice_ninja_sync_report --include-details

Author: Django-Invoice Ninja Integration Team
Created: 2025-01-25
"""

import csv
from django.core.management.base import BaseCommand, CommandError
from django.contrib.auth import get_user_model
from django.conf import settings
from django.utils import timezone
from apps.invoice_ninja_utils import SyncStatusManager

User = get_user_model()


class Command(BaseCommand):
    help = 'Generate a report of Invoice Ninja synchronization status'

    def add_arguments(self, parser):
        parser.add_argument(
            '--status',
            type=str,
            choices=['pending', 'synced', 'failed', 'retry'],
            help='Filter users by sync status',
        )
        parser.add_argument(
            '--export-csv',
            type=str,
            help='Export report to CSV file',
        )
        parser.add_argument(
            '--include-details',
            action='store_true',
            help='Include detailed user information in the report',
        )

    def handle(self, *args, **options):
        self.stdout.write(
            self.style.SUCCESS('Generating Invoice Ninja sync status report...')
        )

        status_filter = options.get('status')
        export_csv = options.get('export_csv')
        include_details = options.get('include_details')

        # Get users based on filter
        if status_filter:
            users = User.objects.filter(invoiceninja_sync_status=status_filter)
        else:
            users = User.objects.all()

        # Generate report data
        report_data = self._generate_report_data(users, include_details)
        
        # Display report
        self._display_report(report_data, include_details)
        
        # Export to CSV if requested
        if export_csv:
            self._export_to_csv(report_data, export_csv, include_details)

        self.stdout.write(
            self.style.SUCCESS('Report generation completed.')
        )

    def _generate_report_data(self, users, include_details):
        """Generate report data structure"""
        
        report_data = {
            'summary': {
                'total_users': users.count(),
                'synced': 0,
                'pending': 0,
                'failed': 0,
                'retry': 0,
                'not_started': 0,
            },
            'users': []
        }

        for user in users:
            sync_status = getattr(user, 'invoiceninja_sync_status', 'not_started')
            
            # Update summary counts
            if sync_status in report_data['summary']:
                report_data['summary'][sync_status] += 1
            else:
                report_data['summary']['not_started'] += 1

            # Prepare user data
            user_data = {
                'id': user.id,
                'username': user.username,
                'email': user.email,
                'sync_status': sync_status,
                'client_id': getattr(user, 'invoiceninja_client_id', None),
                'sync_attempts': getattr(user, 'invoiceninja_sync_attempts', 0),
                'last_sync_attempt': getattr(user, 'invoiceninja_last_sync_attempt', None),
                'date_joined': user.date_joined,
            }

            if include_details:
                user_data.update({
                    'first_name': user.first_name,
                    'last_name': user.last_name,
                    'phone_number': getattr(user, 'phone_number', ''),
                    'nationality': str(getattr(user, 'nationality', '')),
                    'referral_code': getattr(user, 'referral_code', ''),
                    'referred_by': getattr(user, 'referred_by', ''),
                    'is_active': user.is_active,
                })

            report_data['users'].append(user_data)

        return report_data

    def _display_report(self, report_data, include_details):
        """Display report in the console"""
        
        summary = report_data['summary']
        
        # Display summary
        self.stdout.write('\n' + '='*60)
        self.stdout.write(self.style.SUCCESS('INVOICE NINJA SYNC STATUS SUMMARY'))
        self.stdout.write('='*60)
        self.stdout.write(f'Total Users: {summary["total_users"]}')
        self.stdout.write('')
        self.stdout.write(f'✓ Synced:      {summary["synced"]} ({self._percentage(summary["synced"], summary["total_users"])}%)')
        self.stdout.write(f'⏳ Pending:     {summary["pending"]} ({self._percentage(summary["pending"], summary["total_users"])}%)')
        self.stdout.write(f'🔄 Retry:       {summary["retry"]} ({self._percentage(summary["retry"], summary["total_users"])}%)')
        self.stdout.write(f'✗ Failed:      {summary["failed"]} ({self._percentage(summary["failed"], summary["total_users"])}%)')
        self.stdout.write(f'- Not Started: {summary["not_started"]} ({self._percentage(summary["not_started"], summary["total_users"])}%)')
        
        # Display detailed user list if there are issues
        problem_statuses = ['pending', 'retry', 'failed']
        problem_users = [u for u in report_data['users'] if u['sync_status'] in problem_statuses]
        
        if problem_users:
            self.stdout.write('\n' + '='*60)
            self.stdout.write(self.style.WARNING('USERS REQUIRING ATTENTION'))
            self.stdout.write('='*60)
            
            for user in problem_users:
                status_icon = {
                    'pending': '⏳',
                    'retry': '🔄',
                    'failed': '✗',
                }.get(user['sync_status'], '?')
                
                self.stdout.write(
                    f'{status_icon} User {user["id"]} ({user["username"]}) - '
                    f'Status: {user["sync_status"]}, '
                    f'Attempts: {user["sync_attempts"]}'
                )
                
                if user['last_sync_attempt']:
                    self.stdout.write(f'    Last attempt: {user["last_sync_attempt"]}')

        # Display recent activity
        recent_users = sorted(
            [u for u in report_data['users'] if u['last_sync_attempt']],
            key=lambda x: x['last_sync_attempt'] or timezone.datetime.min.replace(tzinfo=timezone.utc),
            reverse=True
        )[:10]
        
        if recent_users:
            self.stdout.write('\n' + '='*60)
            self.stdout.write(self.style.SUCCESS('RECENT SYNC ACTIVITY (Last 10)'))
            self.stdout.write('='*60)
            
            for user in recent_users:
                status_color = {
                    'synced': self.style.SUCCESS,
                    'pending': self.style.WARNING,
                    'retry': self.style.WARNING,
                    'failed': self.style.ERROR,
                }.get(user['sync_status'], self.style.NOTICE)
                
                self.stdout.write(
                    status_color(
                        f'User {user["id"]} ({user["username"]}) - '
                        f'{user["sync_status"]} at {user["last_sync_attempt"]}'
                    )
                )

    def _export_to_csv(self, report_data, file_path, include_details):
        """Export report data to CSV file"""
        
        try:
            with open(file_path, 'w', newline='', encoding='utf-8') as csvfile:
                # Determine fieldnames
                if include_details:
                    fieldnames = [
                        'id', 'username', 'email', 'first_name', 'last_name',
                        'phone_number', 'nationality', 'referral_code', 'referred_by',
                        'sync_status', 'client_id', 'sync_attempts', 'last_sync_attempt',
                        'date_joined', 'is_active'
                    ]
                else:
                    fieldnames = [
                        'id', 'username', 'email', 'sync_status', 'client_id',
                        'sync_attempts', 'last_sync_attempt', 'date_joined'
                    ]

                writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
                writer.writeheader()
                
                for user in report_data['users']:
                    # Filter user data to match fieldnames
                    row_data = {k: v for k, v in user.items() if k in fieldnames}
                    
                    # Format dates for CSV
                    if row_data.get('last_sync_attempt'):
                        row_data['last_sync_attempt'] = row_data['last_sync_attempt'].isoformat()
                    if row_data.get('date_joined'):
                        row_data['date_joined'] = row_data['date_joined'].isoformat()
                    
                    writer.writerow(row_data)

            self.stdout.write(
                self.style.SUCCESS(f'Report exported to: {file_path}')
            )
            
        except Exception as e:
            self.stdout.write(
                self.style.ERROR(f'Failed to export CSV: {str(e)}')
            )

    def _percentage(self, part, total):
        """Calculate percentage"""
        if total == 0:
            return 0
        return round((part / total) * 100, 1)
