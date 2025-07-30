#!/usr/bin/env python
"""
Final sync status summary script
Shows the complete integration status between Django and Invoice Ninja
"""

from django.core.management.base import BaseCommand
from apps.models import TreatmentProduct, TreatmentPlan, User

class Command(BaseCommand):
    help = 'Show complete sync status summary between Django and Invoice Ninja'
    
    def handle(self, *args, **options):
        self.stdout.write(self.style.SUCCESS('🚀 Django ↔ Invoice Ninja Integration Summary'))
        self.stdout.write('=' * 60)
        
        # Products sync status
        products = TreatmentProduct.objects.all()
        synced_products = products.filter(invoiceninja_product_id__isnull=False)
        self.stdout.write(f'\n📦 PRODUCTS SYNC STATUS:')
        self.stdout.write(f'Total products: {products.count()}')
        self.stdout.write(f'Synced to Invoice Ninja: {synced_products.count()}')
        self.stdout.write(f'Status: {"✅ ALL SYNCED" if synced_products.count() == products.count() else "❌ INCOMPLETE"}')
        
        # Users/Clients sync status  
        users = User.objects.all()
        synced_users = users.filter(invoiceninja_client_id__isnull=False)
        self.stdout.write(f'\n👥 USERS/CLIENTS SYNC STATUS:')
        self.stdout.write(f'Total users: {users.count()}')
        self.stdout.write(f'Synced to Invoice Ninja: {synced_users.count()}')
        
        # Treatment plans sync status
        treatment_plans = TreatmentPlan.objects.all()
        synced_plans = treatment_plans.filter(invoiceninja_quote_id__isnull=False)
        self.stdout.write(f'\n📋 TREATMENT PLANS/QUOTES SYNC STATUS:')
        self.stdout.write(f'Total treatment plans: {treatment_plans.count()}')
        self.stdout.write(f'Synced as quotes: {synced_plans.count()}')
        self.stdout.write(f'Status: {"✅ ALL SYNCED" if synced_plans.count() == treatment_plans.count() else "❌ INCOMPLETE"}')
        
        # Detailed treatment plan breakdown
        if treatment_plans.exists():
            self.stdout.write(f'\n📋 TREATMENT PLAN DETAILS:')
            for tp in treatment_plans:
                patient_status = "✅" if tp.patient.invoiceninja_client_id else "❌"
                quote_status = "✅" if tp.invoiceninja_quote_id else "❌"
                
                self.stdout.write(f'Plan {tp.id}: {tp.patient.get_full_name()} | Dr. {tp.doctor.get_full_name()}')
                self.stdout.write(f'  └── Patient as Client: {patient_status} {tp.patient.invoiceninja_client_id or "NOT SYNCED"}')
                self.stdout.write(f'  └── Plan as Quote: {quote_status} {tp.invoiceninja_quote_id or "NOT SYNCED"}')
                self.stdout.write(f'  └── Total: ${tp.total_price or "0.00"} | Items: {tp.treatmentplanitem_set.count()}')
        
        # Final status
        all_products_synced = synced_products.count() == products.count()
        all_plans_synced = synced_plans.count() == treatment_plans.count()
        
        self.stdout.write(f'\n🎯 OVERALL INTEGRATION STATUS:')
        if all_products_synced and all_plans_synced:
            self.stdout.write(self.style.SUCCESS('✅ COMPLETE: All data successfully synced to Invoice Ninja!'))
        else:
            self.stdout.write(self.style.WARNING('⚠️  INCOMPLETE: Some data still needs to be synced'))
        
        self.stdout.write(f'\n📊 SUMMARY:')
        self.stdout.write(f'Products: {synced_products.count()}/{products.count()}')
        self.stdout.write(f'Users as Clients: {synced_users.count()}/{users.count()}')
        self.stdout.write(f'Treatment Plans as Quotes: {synced_plans.count()}/{treatment_plans.count()}')
