#!/usr/bin/env python
import os
import django
import sys

# Add the project root to the Python path
sys.path.append(os.path.dirname(os.path.abspath(__file__)))

# Set the Django settings module
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'mysite.settings')

# Setup Django
django.setup()

from apps.models import TreatmentPlan, User

def check_patient_sync_status():
    treatment_plans = TreatmentPlan.objects.all()
    print(f'Total treatment plans: {treatment_plans.count()}')
    
    print('\nChecking patient sync status for each treatment plan:')
    synced_count = 0
    not_synced_count = 0
    
    for tp in treatment_plans:
        patient = tp.patient
        patient_email = patient.email
        ninja_client_id = patient.invoice_ninja_client_id
        sync_status = 'SYNCED' if ninja_client_id else 'NOT SYNCED'
        
        if ninja_client_id:
            synced_count += 1
        else:
            not_synced_count += 1
        
        print(f'Treatment Plan ID: {tp.id}, Patient: {patient_email}, Client ID: {ninja_client_id}, Status: {sync_status}')
    
    print(f'\nSummary:')
    print(f'Synced patients: {synced_count}')
    print(f'Not synced patients: {not_synced_count}')
    
    if not_synced_count == 0:
        print('✅ All patients with treatment plans are synced as clients!')
    else:
        print(f'⚠️  {not_synced_count} patients still need to be synced as clients.')

if __name__ == '__main__':
    check_patient_sync_status()
