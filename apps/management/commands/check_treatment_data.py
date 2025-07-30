from django.core.management.base import BaseCommand
from apps.models import TreatmentPlan, TreatmentPlanItem

class Command(BaseCommand):
    help = 'Check treatment plan data to debug quantity and pricing issues'
    
    def handle(self, *args, **options):
        for plan in TreatmentPlan.objects.all():
            self.stdout.write(f'Plan {plan.id}: {plan.patient.get_full_name()}')
            for item in plan.treatmentplanitem_set.all():
                self.stdout.write(f'  - {item.product.name}: qty={item.quantity}, price=${item.product.price}, discount={item.discount_percentage}%')
            self.stdout.write(f'  Plan total: ${plan.total_price}, subtotal: ${plan.subtotal}, discount: {plan.final_discount_percentage}%')
            self.stdout.write('')
