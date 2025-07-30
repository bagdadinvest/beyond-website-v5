#!/usr/bin/env python
"""
Script to check Invoice Ninja sync status
"""

import os
import sys
import django

# Add the project directory to Python path
sys.path.append('/home/lotfi/apps/beyond-website-v5')

# Set up Django environment
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'core.settings')
django.setup()

from apps.models import TreatmentProduct

def check_sync_status():
    """Check Invoice Ninja sync status for all products"""
    print("=" * 60)
    print("INVOICE NINJA SYNC STATUS")
    print("=" * 60)
    
    products = TreatmentProduct.objects.all()
    
    synced_products = products.exclude(invoiceninja_product_id__isnull=True).exclude(invoiceninja_product_id='')
    pending_products = products.filter(invoiceninja_product_id__isnull=True)
    
    print(f"📊 SYNC SUMMARY:")
    print(f"   Total Products: {products.count()}")
    print(f"   ✅ Synced: {synced_products.count()}")
    print(f"   ⏳ Pending: {pending_products.count()}")
    print("-" * 60)
    
    print("\n✅ SYNCED PRODUCTS:")
    for product in synced_products:
        print(f"   • {product.name}")
        print(f"     Django ID: {product.id}")
        print(f"     Invoice Ninja ID: {product.invoiceninja_product_id}")
        print(f"     Sync Status: {product.invoiceninja_sync_status}")
        print(f"     Last Sync: {product.invoiceninja_last_sync_attempt}")
        print()
    
    if pending_products.exists():
        print("⏳ PENDING PRODUCTS:")
        for product in pending_products:
            print(f"   • {product.name} (ID: {product.id})")
        print()
    
    print("🎯 To sync remaining products, run:")
    print("   python manage.py sync_products_to_invoice_ninja")

if __name__ == "__main__":
    try:
        check_sync_status()
    except Exception as e:
        print(f"Error: {e}")
        import traceback
        traceback.print_exc()
