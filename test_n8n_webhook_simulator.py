    #!/usr/bin/env python
"""
n8n Webhook Simulator
This script simulates how n8n would receive and process webhooks from Django
"""

import json
import requests
import time
from datetime import datetime
from typing import Dict, Any
import hmac
import hashlib

class N8nWebhookSimulator:
    """Simulates n8n webhook processing for Invoice Ninja integration"""
    
    def __init__(self, webhook_secret: str = "test-secret-123"):
        self.webhook_secret = webhook_secret
        self.invoice_ninja_api_url = "https://invoicing.co/api/v1"
        self.invoice_ninja_token = "your-invoice-ninja-api-token"
        self.django_callback_url = "http://localhost:8000/api/invoice-ninja/client-created/"
    
    def verify_webhook_signature(self, payload: str, signature: str) -> bool:
        """Verify webhook signature like n8n would"""
        expected_signature = hmac.new(
            self.webhook_secret.encode(),
            payload.encode(),
            hashlib.sha256
        ).hexdigest()
        return hmac.compare_digest(f"sha256={expected_signature}", signature)
    
    def process_webhook(self, webhook_data: Dict[str, Any]) -> Dict[str, Any]:
        """Process incoming webhook data like n8n would"""
        print("\n" + "="*60)
        print(" N8N WEBHOOK PROCESSING SIMULATION")
        print("="*60)
        
        print(f"Received at: {datetime.now()}")
        print(f"Event type: {webhook_data.get('event')}")
        print(f"Timestamp: {webhook_data.get('timestamp')}")
        
        # Extract user data
        user_data = webhook_data.get('data', {})
        django_user_id = user_data.get('django_user_id')
        
        print(f"\nProcessing user: {user_data.get('email')} (Django ID: {django_user_id})")
        
        # Step 1: Transform data for Invoice Ninja
        invoice_ninja_data = self.transform_for_invoice_ninja(user_data)
        
        # Step 2: Simulate Invoice Ninja API call
        api_result = self.simulate_invoice_ninja_api_call(invoice_ninja_data)
        
        # Step 3: Send callback to Django
        callback_result = self.send_django_callback(django_user_id, api_result)
        
        return {
            'webhook_received': True,
            'invoice_ninja_data': invoice_ninja_data,
            'api_result': api_result,
            'callback_result': callback_result,
            'processing_time': datetime.now()
        }
    
    def transform_for_invoice_ninja(self, user_data: Dict[str, Any]) -> Dict[str, Any]:
        """Transform Django user data to Invoice Ninja client format"""
        print("\n--- Data Transformation for Invoice Ninja ---")
        
        # Extract name components
        first_name = user_data.get('first_name', '')
        last_name = user_data.get('last_name', '')
        full_name = f"{first_name} {last_name}".strip() or user_data.get('username', '')
        
        # Map nationality to country (simplified mapping)
        nationality_to_country = {
            'US': 840,  # United States
            'ES': 724,  # Spain  
            'AE': 784,  # United Arab Emirates
            'TR': 792,  # Turkey
            'DE': 276,  # Germany
            'GB': 826,  # United Kingdom
            'FR': 250,  # France
            'IT': 380,  # Italy
        }
        
        country_id = nationality_to_country.get(user_data.get('nationality'), 840)  # Default to US
        
        invoice_ninja_data = {
            "name": full_name,
            "email": user_data.get('email'),
            "phone": user_data.get('phone_number'),
            "website": "",
            "address1": user_data.get('address', ''),
            "address2": "",
            "city": "",
            "state": "",
            "postal_code": "",
            "country_id": country_id,
            "custom_value1": str(user_data.get('django_user_id', '')),  # Django user ID
            "custom_value2": user_data.get('nationality', ''),
            "custom_value3": str(user_data.get('date_of_birth', '')),
            "custom_value4": user_data.get('referral_code', ''),
            "public_notes": f"Medical tourism patient created from Django at {datetime.now()}",
            "private_notes": f"Django User ID: {user_data.get('django_user_id')}",
        }
        
        # Remove empty values
        invoice_ninja_data = {k: v for k, v in invoice_ninja_data.items() if v}
        
        print("Transformed data:")
        print(json.dumps(invoice_ninja_data, indent=2))
        
        return invoice_ninja_data
    
    def simulate_invoice_ninja_api_call(self, client_data: Dict[str, Any]) -> Dict[str, Any]:
        """Simulate Invoice Ninja API call"""
        print("\n--- Simulating Invoice Ninja API Call ---")
        
        # Simulate different scenarios
        scenarios = [
            {
                'name': 'SUCCESS',
                'probability': 0.7,
                'response': {
                    'success': True,
                    'data': {
                        'id': f"client_{int(time.time())}",
                        'name': client_data.get('name'),
                        'email': client_data.get('email'),
                        'created_at': datetime.now().isoformat(),
                    },
                    'message': 'Client created successfully'
                }
            },
            {
                'name': 'EMAIL_EXISTS',
                'probability': 0.2,
                'response': {
                    'success': False,
                    'error': 'Email already exists',
                    'error_code': 'EMAIL_DUPLICATE',
                    'retry': False,
                    'message': f"Email {client_data.get('email')} already exists in Invoice Ninja"
                }
            },
            {
                'name': 'VALIDATION_ERROR',
                'probability': 0.05,
                'response': {
                    'success': False,
                    'error': 'Validation failed',
                    'error_code': 'VALIDATION_ERROR',
                    'retry': True,
                    'message': 'Required field missing or invalid format'
                }
            },
            {
                'name': 'API_ERROR',
                'probability': 0.05,
                'response': {
                    'success': False,
                    'error': 'API temporarily unavailable',
                    'error_code': 'API_ERROR',
                    'retry': True,
                    'message': 'Invoice Ninja API is temporarily unavailable'
                }
            }
        ]
        
        # Simulate scenario selection (for testing, use SUCCESS)
        selected_scenario = scenarios[0]  # Always use success for testing
        
        print(f"Scenario: {selected_scenario['name']}")
        print(f"API URL: {self.invoice_ninja_api_url}/clients")
        print(f"Method: POST")
        print(f"Headers: X-API-TOKEN, X-Requested-With")
        print(f"Payload: {json.dumps(client_data, indent=2)}")
        
        result = selected_scenario['response'].copy()
        result['scenario'] = selected_scenario['name']
        result['api_call_time'] = datetime.now().isoformat()
        
        print(f"\nSimulated API Response:")
        print(json.dumps(result, indent=2))
        
        return result
    
    def send_django_callback(self, django_user_id: int, api_result: Dict[str, Any]) -> Dict[str, Any]:
        """Send callback to Django with results"""
        print("\n--- Sending Django Callback ---")
        
        if api_result.get('success'):
            callback_data = {
                'django_user_id': django_user_id,
                'invoice_ninja_client_id': api_result['data']['id'],
                'success': True,
                'message': api_result.get('message', 'Client created successfully'),
                'timestamp': datetime.now().isoformat()
            }
        else:
            callback_data = {
                'django_user_id': django_user_id,
                'success': False,
                'error': api_result.get('error'),
                'error_code': api_result.get('error_code'),
                'retry': api_result.get('retry', False),
                'message': api_result.get('message'),
                'timestamp': datetime.now().isoformat()
            }
        
        print(f"Callback URL: {self.django_callback_url}")
        print(f"Method: POST")
        print(f"Headers: Content-Type: application/json, X-Webhook-Secret")
        print(f"Payload:")
        print(json.dumps(callback_data, indent=2))
        
        # Simulate HTTP call to Django (don't actually make it unless Django is running)
        try:
            # You can uncomment this to actually test against running Django
            # response = requests.post(
            #     self.django_callback_url,
            #     json=callback_data,
            #     headers={
            #         'Content-Type': 'application/json',
            #         'X-Webhook-Secret': self.webhook_secret
            #     },
            #     timeout=10
            # )
            # return {'status_code': response.status_code, 'response': response.text}
            
            return {
                'simulated': True,
                'status_code': 200,
                'message': 'Callback would be sent to Django'
            }
        except Exception as e:
            return {
                'simulated': True,
                'error': str(e),
                'message': 'Callback simulation failed'
            }

def create_sample_webhook_payload() -> Dict[str, Any]:
    """Create a sample webhook payload that Django would send"""
    return {
        "event": "user.created",
        "timestamp": datetime.now().isoformat(),
        "data": {
            "django_user_id": 12345,
            "username": "test.patient@example.com",
            "email": "test.patient@example.com",
            "first_name": "John",
            "last_name": "Doe",
            "phone_number": "+1-555-0123",
            "date_of_birth": "1985-03-15",
            "nationality": "US",
            "address": "123 Main St, New York, NY 10001",
            "referral_code": "REF123",
            "created": datetime.now().isoformat(),
            "is_active": True
        }
    }

def test_n8n_processing():
    """Test the complete n8n processing flow"""
    print("Testing n8n Webhook Processing Flow")
    print("="*50)
    
    # Create simulator
    simulator = N8nWebhookSimulator()
    
    # Create sample webhook data
    webhook_data = create_sample_webhook_payload()
    
    print("Sample Django Webhook Payload:")
    print(json.dumps(webhook_data, indent=2))
    
    # Process the webhook
    result = simulator.process_webhook(webhook_data)
    
    print("\n" + "="*60)
    print(" PROCESSING COMPLETE")
    print("="*60)
    print(f"Success: {result['api_result'].get('success', False)}")
    print(f"Processing time: {result['processing_time']}")
    
    return result

def test_multiple_scenarios():
    """Test multiple user scenarios"""
    print("\n\nTesting Multiple User Scenarios")
    print("="*50)
    
    scenarios = [
        {
            "name": "US Patient",
            "data": {
                "django_user_id": 1001,
                "username": "us.patient@example.com",
                "email": "us.patient@example.com", 
                "first_name": "Sarah",
                "last_name": "Johnson",
                "phone_number": "+1-555-0199",
                "nationality": "US",
                "address": "456 Oak Ave, Los Angeles, CA 90210"
            }
        },
        {
            "name": "Spanish Patient",
            "data": {
                "django_user_id": 1002,
                "username": "spanish.patient@example.com",
                "email": "spanish.patient@example.com",
                "first_name": "Carlos", 
                "last_name": "Rodriguez",
                "phone_number": "+34-612-345-678",
                "nationality": "ES",
                "address": "Calle Gran Via 123, Madrid, Spain"
            }
        },
        {
            "name": "UAE Patient", 
            "data": {
                "django_user_id": 1003,
                "username": "uae.patient@example.com",
                "email": "uae.patient@example.com",
                "first_name": "Ahmed",
                "last_name": "Al-Mahmoud", 
                "phone_number": "+971-50-123-4567",
                "nationality": "AE",
                "address": "Sheikh Zayed Road, Dubai, UAE"
            }
        }
    ]
    
    simulator = N8nWebhookSimulator()
    
    for scenario in scenarios:
        print(f"\n--- Testing {scenario['name']} ---")
        
        webhook_payload = {
            "event": "user.created",
            "timestamp": datetime.now().isoformat(),
            "data": scenario['data']
        }
        
        result = simulator.process_webhook(webhook_payload)
        print(f"Result: {'SUCCESS' if result['api_result'].get('success') else 'FAILED'}")

if __name__ == "__main__":
    # Test single scenario
    test_n8n_processing()
    
    # Test multiple scenarios
    test_multiple_scenarios()
    
    print("\n" + "="*60)
    print(" N8N SIMULATION COMPLETE")
    print("="*60)
    print("\nThis simulation shows:")
    print("1. How n8n receives Django webhooks")
    print("2. Data transformation for Invoice Ninja API")
    print("3. Invoice Ninja API call simulation")
    print("4. Django callback with results")
    print("\nUse this to build your actual n8n workflow!")
