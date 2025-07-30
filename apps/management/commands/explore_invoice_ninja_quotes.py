#!/usr/bin/env python
"""
Django Management Command: explore_invoice_ninja_quotes
Explores Invoice Ninja API to understand quotes/estimates schema
"""

from django.core.management.base import BaseCommand
import requests
import json
import os

class Command(BaseCommand):
    help = 'Explore Invoice Ninja API schema for quotes/estimates'

    def add_arguments(self, parser):
        parser.add_argument('--endpoint', type=str, default='quotes', 
                          help='API endpoint to explore (quotes, estimates, etc.)')

    def handle(self, *args, **options):
        endpoint = options['endpoint']
        
        self.stdout.write(f"\n🔍 Exploring Invoice Ninja API: {endpoint}")
        self.stdout.write("="*60)

        api_url = os.getenv('INVOICE_NINJA_API_URL', 'https://tp.delilclinic.com')
        api_token = os.getenv('INVOICE_NINJA_API_TOKEN')
        
        if not api_token:
            self.stdout.write(self.style.ERROR("⚠️  Invoice Ninja API token not configured"))
            return

        # Try different quote-related endpoints
        endpoints_to_try = [
            'quotes',
            'invoices',  # To compare structure
            'clients',   # We'll need this for quotes
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

        # Try to create a test quote to understand the schema
        self.stdout.write(f"\n🧪 Testing quote creation schema")
        self.stdout.write("-" * 40)
        
        # First, let's get a client ID to use for the quote
        clients_url = f"{api_url}/api/v1/clients"
        try:
            clients_response = requests.get(clients_url, headers=headers, timeout=30)
            if clients_response.status_code == 200:
                clients_data = clients_response.json()
                if clients_data['data']:
                    client_id = clients_data['data'][0]['id']
                    self.stdout.write(f"📝 Using client ID: {client_id}")
                    
                    # Now try to create a test quote
                    test_quote_data = {
                        "client_id": client_id,
                        "date": "2025-07-28",
                        "due_date": "2025-08-28",
                        "public_notes": "Test quote for schema exploration",
                        "private_notes": "Internal test quote",
                        "terms": "Payment terms here",
                        "footer": "Footer text",
                        "discount": 10.00,  # Percentage discount
                        "partial": 0,
                        "line_items": [
                            {
                                "product_key": "TEST_PRODUCT_001",
                                "notes": "Test product line item",
                                "cost": 100.00,
                                "qty": 2,
                                "discount": 5.00,  # Line item discount
                                "tax_name1": "",
                                "tax_rate1": 0,
                                "tax_name2": "",
                                "tax_rate2": 0,
                                "custom_value1": "",
                                "custom_value2": "",
                                "custom_value3": "",
                                "custom_value4": ""
                            }
                        ]
                    }
                    
                    quotes_url = f"{api_url}/api/v1/quotes"
                    quote_response = requests.post(quotes_url, json=test_quote_data, headers=headers, timeout=30)
                    self.stdout.write(f"POST quotes test - Status: {quote_response.status_code}")
                    
                    if quote_response.status_code in [200, 201]:
                        result = quote_response.json()
                        self.stdout.write(f"✅ Quote creation successful:")
                        self.stdout.write(json.dumps(result, indent=2, default=str))
                    else:
                        self.stdout.write(f"⚠️  Quote creation failed: {quote_response.text}")
                        # Parse error to understand required fields
                        try:
                            error_data = quote_response.json()
                            if 'errors' in error_data:
                                self.stdout.write(f"📋 Required fields/errors:")
                                self.stdout.write(json.dumps(error_data['errors'], indent=2))
                        except:
                            pass
                else:
                    self.stdout.write("❌ No clients found to create test quote")
            else:
                self.stdout.write(f"❌ Failed to get clients: {clients_response.status_code}")
                    
        except requests.exceptions.RequestException as e:
            self.stdout.write(f"❌ Quote creation test failed: {str(e)}")

        self.stdout.write(f"\n✅ Quote schema exploration complete!")
