#!/usr/bin/env python
"""
Django Management Command: explore_invoice_ninja_schema
Explores Invoice Ninja API to understand product/item schema
"""

from django.core.management.base import BaseCommand
import requests
import json
import os

class Command(BaseCommand):
    help = 'Explore Invoice Ninja API schema for products/items'

    def add_arguments(self, parser):
        parser.add_argument('--endpoint', type=str, default='products', 
                          help='API endpoint to explore (products, items, etc.)')

    def handle(self, *args, **options):
        endpoint = options['endpoint']
        
        self.stdout.write(f"\n🔍 Exploring Invoice Ninja API: {endpoint}")
        self.stdout.write("="*60)

        api_url = os.getenv('INVOICE_NINJA_API_URL', 'https://tp.delilclinic.com')
        api_token = os.getenv('INVOICE_NINJA_API_TOKEN')
        
        if not api_token or api_token == 'your-fake-api-token-here':
            self.stdout.write(self.style.ERROR("⚠️  Invoice Ninja API token not configured"))
            return

        # Try different endpoints to understand the schema
        endpoints_to_try = [
            'products',
            'items', 
            'product_types',
            'tax_rates',
            'categories'
        ]

        for ep in endpoints_to_try:
            self.stdout.write(f"\n📡 Testing endpoint: {ep}")
            self.stdout.write("-" * 40)
            
            url = f"{api_url}/api/v1/{ep}"
            headers = {
                'X-API-TOKEN': api_token,
                'X-Requested-With': 'XMLHttpRequest',
                'Content-Type': 'application/json',
            }

            try:
                # First try GET to see existing data
                response = requests.get(url, headers=headers, timeout=30)
                self.stdout.write(f"GET {ep} - Status: {response.status_code}")
                
                if response.status_code == 200:
                    result = response.json()
                    self.stdout.write(f"✅ Response structure:")
                    self.stdout.write(json.dumps(result, indent=2, default=str)[:1000] + "...")
                    
                    # If we have data, show the first item structure
                    if 'data' in result and result['data']:
                        self.stdout.write(f"\n📋 First item structure:")
                        first_item = result['data'][0]
                        self.stdout.write(json.dumps(first_item, indent=2, default=str))
                        
                elif response.status_code == 404:
                    self.stdout.write(f"❌ Endpoint {ep} not found")
                else:
                    self.stdout.write(f"⚠️  Status {response.status_code}: {response.text}")
                    
            except requests.exceptions.RequestException as e:
                self.stdout.write(f"❌ Request failed for {ep}: {str(e)}")

        # Try to create a test product to understand the required fields
        self.stdout.write(f"\n🧪 Testing product creation schema")
        self.stdout.write("-" * 40)
        
        test_product_data = {
            "product_key": "TEST_PRODUCT_001",
            "notes": "Test product for schema exploration",
            "cost": 100.00,
            "price": 150.00,
            "quantity": 1,
            "tax_name1": "",
            "tax_rate1": 0,
            "tax_name2": "",
            "tax_rate2": 0,
            "custom_value1": "",
            "custom_value2": "",
            "custom_value3": "",
            "custom_value4": ""
        }
        
        url = f"{api_url}/api/v1/products"
        try:
            response = requests.post(url, json=test_product_data, headers=headers, timeout=30)
            self.stdout.write(f"POST products test - Status: {response.status_code}")
            
            if response.status_code in [200, 201]:
                result = response.json()
                self.stdout.write(f"✅ Product creation successful:")
                self.stdout.write(json.dumps(result, indent=2, default=str))
            else:
                self.stdout.write(f"⚠️  Product creation failed: {response.text}")
                # Parse error to understand required fields
                try:
                    error_data = response.json()
                    if 'errors' in error_data:
                        self.stdout.write(f"📋 Required fields/errors:")
                        self.stdout.write(json.dumps(error_data['errors'], indent=2))
                except:
                    pass
                    
        except requests.exceptions.RequestException as e:
            self.stdout.write(f"❌ Product creation test failed: {str(e)}")

        self.stdout.write(f"\n✅ Schema exploration complete!")
