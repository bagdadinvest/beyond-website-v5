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

from apps.models import TreatmentPlan, TreatmentPlanItem

def check_treatment_data():
    for plan in TreatmentPlan.objects.all():
        print(f'Plan {plan.id}: {plan.patient.get_full_name()}')
        for item in plan.treatmentplanitem_set.all():
            print(f'  - {item.product.name}: qty={item.quantity}, price=${item.product.price}, discount={item.discount_percentage}%')
        print(f'  Plan total: ${plan.total_price}, subtotal: ${plan.subtotal}, discount: {plan.final_discount_percentage}%')
        print()

if __name__ == '__main__':
    check_treatment_data()
