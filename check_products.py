#!/usr/bin/env python
"""
Script to check products in the database
"""

import os
import sys
import django

# Add the project directory to Python path
sys.path.append('/home/lotfi/apps/beyond-website-v5')

# Set up Django environment
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'core.settings')
django.setup()

from apps.models import TreatmentProduct, TreatmentPlan, TreatmentPlanItem
from django.contrib.auth.models import User

def check_products():
    """Check all treatment products in the database"""
    print("=" * 60)
    print("TREATMENT PRODUCTS IN DATABASE")
    print("=" * 60)
    
    products = TreatmentProduct.objects.all()
    
    if not products.exists():
        print("No products found in the database.")
        return
    
    print(f"Total products found: {products.count()}")
    print("-" * 60)
    
    for product in products:
        print(f"ID: {product.id}")
        print(f"Name: {product.name}")
        print(f"Slug: {product.slug}")
        print(f"Category: {product.category}")
        print(f"Description: {product.description[:100] if product.description else 'N/A'}...")
        print(f"Price: ${product.price}" if product.price else "Price: Not set")
        print(f"Max Discount: {product.max_discount_percentage}%")
        print(f"Country of Origin: {product.country_of_origin}")
        print(f"Active: {product.is_active}")
        print(f"Image: {product.image_filename() if product.image else 'No image'}")
        print("-" * 40)
    
    # Check product categories
    print("\nPRODUCT CATEGORIES:")
    print("-" * 20)
    categories = products.values_list('category', flat=True).distinct()
    for category in categories:
        count = products.filter(category=category).count()
        print(f"{category}: {count} products")
    
    # Check active vs inactive
    print(f"\nACTIVE PRODUCTS: {products.filter(is_active=True).count()}")
    print(f"INACTIVE PRODUCTS: {products.filter(is_active=False).count()}")
    
    # Check products with/without prices
    print(f"PRODUCTS WITH PRICES: {products.exclude(price__isnull=True).count()}")
    print(f"PRODUCTS WITHOUT PRICES: {products.filter(price__isnull=True).count()}")

def check_treatment_plans():
    """Check treatment plans and their items"""
    print("\n" + "=" * 60)
    print("TREATMENT PLANS IN DATABASE")
    print("=" * 60)
    
    plans = TreatmentPlan.objects.all()
    
    if not plans.exists():
        print("No treatment plans found in the database.")
        return
    
    print(f"Total treatment plans found: {plans.count()}")
    print("-" * 60)
    
    for plan in plans:
        print(f"Plan ID: {plan.id}")
        print(f"Patient: {plan.patient.get_full_name() if plan.patient else 'N/A'}")
        print(f"Doctor: {plan.doctor.get_full_name() if plan.doctor else 'N/A'}")
        print(f"Subtotal: ${plan.subtotal}" if plan.subtotal else "Subtotal: Not calculated")
        print(f"Discount: {plan.final_discount_percentage}%")
        print(f"Total Price: ${plan.total_price}" if plan.total_price else "Total: Not calculated")
        print(f"Created: {plan.created_at}")
        
        # Check plan items
        items = plan.treatmentplanitem_set.all()
        print(f"Items in plan: {items.count()}")
        for item in items:
            print(f"  - {item.quantity}x {item.product.name} (${item.product.price} each, {item.discount_percentage}% discount)")
        print("-" * 40)

if __name__ == "__main__":
    try:
        check_products()
        check_treatment_plans()
    except Exception as e:
        print(f"Error: {e}")
        import traceback
        traceback.print_exc()
