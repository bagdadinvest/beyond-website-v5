from django.core.management.base import BaseCommand
from apps.models import TreatmentPlan, TreatmentProduct

class Command(BaseCommand):
    help = 'Show comprehensive sync status for Invoice Ninja integration'
    
    def handle(self, *args, **options):
        self.stdout.write(self.style.SUCCESS('\n🎯 INVOICE NINJA SYNC STATUS SUMMARY'))
        self.stdout.write('='*60)
        
        # Products sync status
        products = TreatmentProduct.objects.all()
        synced_products = products.filter(invoiceninja_product_id__isnull=False)
        
        self.stdout.write(f'\n📦 PRODUCTS:')
        self.stdout.write(f'   Total: {products.count()}')
        self.stdout.write(f'   Synced: {synced_products.count()}')
        self.stdout.write(f'   Not synced: {products.count() - synced_products.count()}')
        
        # Treatment plans sync status
        plans = TreatmentPlan.objects.all()
        synced_plans = plans.filter(invoiceninja_quote_id__isnull=False)
        
        self.stdout.write(f'\n📋 TREATMENT PLANS (as Quotes):')
        self.stdout.write(f'   Total: {plans.count()}')
        self.stdout.write(f'   Synced: {synced_plans.count()}')
        self.stdout.write(f'   Not synced: {plans.count() - synced_plans.count()}')
        
        # Detailed treatment plan status
        if synced_plans.exists():
            self.stdout.write(f'\n📝 SYNCED TREATMENT PLANS DETAILS:')
            for plan in synced_plans:
                items_count = plan.treatmentplanitem_set.count()
                self.stdout.write(f'   Plan {plan.id}: {plan.patient.get_full_name()} | ${plan.total_price} | {items_count} items | Quote ID: {plan.invoiceninja_quote_id}')
        
        # Patients (clients) sync status
        from django.contrib.auth import get_user_model
        User = get_user_model()
        patients_with_plans = User.objects.filter(patient_plans__isnull=False).distinct()
        synced_patients = patients_with_plans.filter(invoiceninja_client_id__isnull=False)
        
        self.stdout.write(f'\n👥 PATIENTS (as Clients):')
        self.stdout.write(f'   With treatment plans: {patients_with_plans.count()}')
        self.stdout.write(f'   Synced to Invoice Ninja: {synced_patients.count()}')
        self.stdout.write(f'   Not synced: {patients_with_plans.count() - synced_patients.count()}')
        
        # Overall status
        all_synced = (
            synced_products.count() == products.count() and
            synced_plans.count() == plans.count() and
            synced_patients.count() == patients_with_plans.count()
        )
        
        if all_synced:
            self.stdout.write(self.style.SUCCESS('\n✅ ALL SYSTEMS SYNCED! Invoice Ninja integration is complete.'))
        else:
            self.stdout.write(self.style.WARNING('\n⚠️  Some items still need syncing.'))
        
        self.stdout.write('\n' + '='*60)
