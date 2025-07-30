from django.core.management.base import BaseCommand
from apps.models import TreatmentPlan, User

class Command(BaseCommand):
    help = 'Check which patients in treatment plans are synced as Invoice Ninja clients'
    
    def handle(self, *args, **options):
        treatment_plans = TreatmentPlan.objects.all()
        self.stdout.write(f'Total treatment plans: {treatment_plans.count()}')
        
        self.stdout.write('\nChecking patient sync status for each treatment plan:')
        synced_count = 0
        not_synced_count = 0
        
        for tp in treatment_plans:
            patient = tp.patient
            patient_email = patient.email
            ninja_client_id = patient.invoiceninja_client_id
            sync_status = 'SYNCED' if ninja_client_id else 'NOT SYNCED'
            
            if ninja_client_id:
                synced_count += 1
            else:
                not_synced_count += 1
            
            self.stdout.write(f'Treatment Plan ID: {tp.id}, Patient: {patient_email}, Client ID: {ninja_client_id}, Status: {sync_status}')
        
        self.stdout.write(f'\nSummary:')
        self.stdout.write(f'Synced patients: {synced_count}')
        self.stdout.write(f'Not synced patients: {not_synced_count}')
        
        if not_synced_count == 0:
            self.stdout.write(self.style.SUCCESS('✅ All patients with treatment plans are synced as clients!'))
        else:
            self.stdout.write(self.style.WARNING(f'⚠️  {not_synced_count} patients still need to be synced as clients.'))
