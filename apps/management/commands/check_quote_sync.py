from django.core.management.base import BaseCommand
from apps.models import TreatmentPlan

class Command(BaseCommand):
    help = 'Check sync status of treatment plans to Invoice Ninja quotes'
    
    def handle(self, *args, **options):
        treatment_plans = TreatmentPlan.objects.all()
        self.stdout.write(f'Total treatment plans: {treatment_plans.count()}')
        
        self.stdout.write('\nTreatment Plan Sync Status:')
        synced_count = 0
        not_synced_count = 0
        
        for tp in treatment_plans:
            patient = tp.patient
            doctor = tp.doctor
            ninja_quote_id = tp.invoiceninja_quote_id
            sync_status = 'SYNCED' if ninja_quote_id else 'NOT SYNCED'
            
            if ninja_quote_id:
                synced_count += 1
            else:
                not_synced_count += 1
            
            self.stdout.write(f'Plan {tp.id}: {patient.get_full_name()} | Dr. {doctor.get_full_name()} | ${tp.total_price} | Quote ID: {ninja_quote_id} | Status: {sync_status}')
        
        self.stdout.write(f'\nSummary:')
        self.stdout.write(f'Synced plans: {synced_count}')
        self.stdout.write(f'Not synced plans: {not_synced_count}')
        
        if not_synced_count == 0:
            self.stdout.write(self.style.SUCCESS('✅ All treatment plans are synced as quotes!'))
        else:
            self.stdout.write(self.style.WARNING(f'⚠️  {not_synced_count} treatment plans still need to be synced.'))
