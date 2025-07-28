#!/usr/bin/env python
"""
Test script to simulate user signup and Invoice Ninja integration
This script creates test users and monitors the webhook data being sent
"""

import os
import sys
import django
import json
import time
from datetime import datetime

# Load environment variables from .env file
try:
    from dotenv import load_dotenv
    load_dotenv()
    print("Loaded environment variables from .env file")
except ImportError:
    print("python-dotenv not installed, using system environment variables")

# Setup Django
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'core.settings')
django.setup()

from django.contrib.auth import get_user_model
from django.test import Client
from django.urls import reverse
from apps.invoice_ninja_utils import UserDataSerializer, WebhookSender, SyncStatusManager
import logging

# Setup logging to see what's happening
logging.basicConfig(
    level=logging.DEBUG,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s'
)

User = get_user_model()

def print_section(title):
    """Print a formatted section header"""
    print("\n" + "="*80)
    print(f" {title}")
    print("="*80)

def create_test_user_data():
    """Generate test user data for different scenarios"""
    from datetime import date
    test_users = [
        {
            'username': 'test_patient_1@example.com',
            'email': 'test_patient_1@example.com',
            'password': 'TestPass123!',
            'first_name': 'John',
            'last_name': 'Doe',
            'phone_number': '+15550123',
            'date_of_birth': date(1985, 3, 15),
            'nationality': 'US',
        },
        {
            'username': 'test_patient_2@example.com', 
            'email': 'test_patient_2@example.com',
            'password': 'TestPass123!',
            'first_name': 'Maria',
            'last_name': 'Garcia',
            'phone_number': '+34612345678',
            'date_of_birth': date(1990, 7, 22),
            'nationality': 'ES',
        },
        {
            'username': 'test_patient_3@example.com',
            'email': 'test_patient_3@example.com', 
            'password': 'TestPass123!',
            'first_name': 'Ahmed',
            'last_name': 'Al-Rashid',
            'phone_number': '+971501234567',
            'date_of_birth': date(1988, 12, 3),
            'nationality': 'AE',
        }
    ]
    return test_users

def test_user_data_serialization():
    """Test the UserDataSerializer with sample data"""
    print_section("Testing User Data Serialization")
    
    test_users = create_test_user_data()
    
    for i, user_data in enumerate(test_users, 1):
        print(f"\n--- Test User {i} ---")
        print(f"Input Data: {json.dumps(user_data, indent=2, default=str)}")
        
        # Create user object temporarily for testing
        user = User(**user_data)
        user.id = 1000 + i  # Mock ID
        
        # Test serialization
        serializer = UserDataSerializer()
        serialized_data = serializer.serialize_user_for_invoice_ninja(user)
        
        print(f"\nSerialized for Invoice Ninja:")
        print(json.dumps(serialized_data, indent=2, default=str))
        
        # Analyze the data
        print(f"\nData Analysis:")
        print(f"- Has contact info: {'phone_number' in serialized_data}")
        print(f"- Has nationality: {'nationality' in serialized_data}")
        print(f"- Has date of birth: {'date_of_birth' in serialized_data}")
        print(f"- Total fields: {len(serialized_data)}")

def test_webhook_payload_structure():
    """Test the complete webhook payload structure"""
    print_section("Testing Webhook Payload Structure")
    
    # Create a real test user
    test_user_data = create_test_user_data()[0]
    
    # Check if user already exists and delete if so
    try:
        existing_user = User.objects.get(email=test_user_data['email'])
        existing_user.delete()
        print(f"Deleted existing test user: {test_user_data['email']}")
    except User.DoesNotExist:
        pass
    
    # Create user
    user = User.objects.create_user(**test_user_data)
    print(f"Created test user: {user.email} (ID: {user.id})")
    
    # Test webhook payload creation
    webhook_sender = WebhookSender()
    payload = webhook_sender._create_webhook_payload(user, 'user.created')
    
    print(f"\nWebhook Payload:")
    print(json.dumps(payload, indent=2, default=str))
    
    # Analyze payload structure
    print(f"\nPayload Analysis:")
    print(f"- Event type: {payload.get('event')}")
    print(f"- Has timestamp: {'timestamp' in payload}")
    print(f"- Has user data: {'data' in payload}")
    print(f"- User data fields: {list(payload.get('data', {}).keys())}")
    
    return user

def test_sync_status_management():
    """Test sync status management functions"""
    print_section("Testing Sync Status Management")
    
    # Create a test user
    test_user_data = create_test_user_data()[1]
    test_user_data['email'] = 'sync_test@example.com'
    test_user_data['username'] = 'sync_test@example.com'
    
    # Clean up existing user
    try:
        existing_user = User.objects.get(email=test_user_data['email'])
        existing_user.delete()
    except User.DoesNotExist:
        pass
        
    user = User.objects.create_user(**test_user_data)
    print(f"Created sync test user: {user.email} (ID: {user.id})")
    
    sync_manager = SyncStatusManager()
    
    # Test initial status
    print(f"\nInitial sync status: {user.invoiceninja_sync_status}")
    print(f"Initial sync attempts: {user.invoiceninja_sync_attempts}")
    
    # Test marking as pending
    sync_manager.mark_as_pending(user)
    user.refresh_from_db()
    print(f"After marking pending: {user.invoiceninja_sync_status}")
    
    # Test marking as failed
    sync_manager.mark_as_failed(user, "Test error message")
    user.refresh_from_db()
    print(f"After marking failed: {user.invoiceninja_sync_status}")
    print(f"Sync attempts: {user.invoiceninja_sync_attempts}")
    print(f"Last attempt: {user.invoiceninja_last_sync_attempt}")
    
    # Test marking as synced
    sync_manager.mark_as_synced(user, "test_client_123")
    user.refresh_from_db()
    print(f"After marking synced: {user.invoiceninja_sync_status}")
    print(f"Client ID: {user.invoiceninja_client_id}")
    
    return user

def simulate_signup_via_django_view():
    """Simulate actual signup through Django views"""
    print_section("Simulating Signup Via Django Views")
    
    client = Client()
    
    # Test user data
    signup_data = {
        'username': 'django_signup_test@example.com',
        'email': 'django_signup_test@example.com', 
        'password1': 'TestPass123!',
        'password2': 'TestPass123!',
        'first_name': 'Django',
        'last_name': 'Test',
        'phone_number': '+15559999',
        'date_of_birth': '1995-01-01',
        'nationality': 'US',
    }
    
    print(f"Signup data: {json.dumps(signup_data, indent=2)}")
    
    # Clean up existing user
    try:
        existing_user = User.objects.get(email=signup_data['email'])
        existing_user.delete()
        print(f"Deleted existing user: {signup_data['email']}")
    except User.DoesNotExist:
        pass
    
    # Try to find signup URL
    try:
        signup_url = reverse('signup')  # Adjust based on your URL name
        print(f"Found signup URL: {signup_url}")
        
        response = client.post(signup_url, signup_data)
        print(f"Signup response status: {response.status_code}")
        
        if response.status_code == 302:  # Redirect after successful signup
            print("Signup appears successful (redirected)")
            
            # Check if user was created
            try:
                new_user = User.objects.get(email=signup_data['email'])
                print(f"User created successfully: {new_user.email} (ID: {new_user.id})")
                print(f"Sync status: {new_user.invoiceninja_sync_status}")
                return new_user
            except User.DoesNotExist:
                print("User was not created despite successful response")
                
        else:
            print(f"Signup failed. Response content: {response.content.decode()[:500]}")
            
    except Exception as e:
        print(f"Could not test signup view: {e}")
        print("This is expected if signup URL pattern is different")
        
        # Create user directly to simulate signal triggering
        print("\nCreating user directly to trigger signals...")
        try:
            from datetime import date
            user = User.objects.create_user(**{
                'username': signup_data['username'],
                'email': signup_data['email'],
                'password': signup_data['password1'],
                'first_name': signup_data['first_name'],
                'last_name': signup_data['last_name'],
                'phone_number': signup_data.get('phone_number'),
                'date_of_birth': date(1995, 1, 1) if signup_data.get('date_of_birth') else None,
                'nationality': signup_data.get('nationality'),
            })
            print(f"User created via ORM: {user.email} (ID: {user.id})")
            print(f"Sync status: {user.invoiceninja_sync_status}")
            return user
        except Exception as create_error:
            print(f"Error creating user: {create_error}")
            return None

def analyze_webhook_requirements():
    """Analyze what data n8n/external service will receive"""
    print_section("Analyzing Webhook Requirements for n8n/External Service")
    
    # Create sample user
    user_data = create_test_user_data()[0]
    user_data['email'] = 'webhook_analysis@example.com'
    user_data['username'] = 'webhook_analysis@example.com'
    
    # Clean up
    try:
        existing_user = User.objects.get(email=user_data['email'])
        existing_user.delete()
    except User.DoesNotExist:
        pass
        
    user = User.objects.create_user(**user_data)
    
    # Generate webhook payload
    webhook_sender = WebhookSender()
    payload = webhook_sender._create_webhook_payload(user, 'user.created')
    
    print("Complete Webhook Payload for n8n/External Service:")
    print(json.dumps(payload, indent=2, default=str))
    
    print("\n" + "-"*60)
    print("EXPECTED N8N/EXTERNAL SERVICE PROCESSING:")
    print("-"*60)
    
    print("\n1. Webhook Reception:")
    print(f"   - URL: {os.getenv('INVOICE_NINJA_WEBHOOK_URL', 'NOT_SET')}")
    print(f"   - Method: POST")
    print(f"   - Content-Type: application/json")
    print(f"   - Secret Header: X-Webhook-Secret")
    
    print("\n2. Data Extraction for Invoice Ninja:")
    invoice_ninja_data = {
        "name": f"{user.first_name} {user.last_name}",
        "email": user.email,
        "phone": user.phone_number,
        "address1": user.address,
        "country_id": "1",  # You'll need to map nationality to Invoice Ninja country IDs
        "custom_value1": str(user.id),  # Django user ID for reference
        "custom_value2": user.nationality,
        "custom_value3": str(user.date_of_birth) if user.date_of_birth else "",
        "custom_value4": user.referral_code if hasattr(user, 'referral_code') else "",
    }
    
    print("\n3. Invoice Ninja API Call Data:")
    print(json.dumps(invoice_ninja_data, indent=2))
    
    print("\n4. Expected Response Processing:")
    print("   - If successful: Extract client ID and send success callback")
    print("   - If failed: Send failure callback with error details")
    
    print("\n5. Django Callback URLs:")
    print(f"   - Success: POST /api/invoice-ninja/client-created/")
    print(f"   - Bulk: POST /api/invoice-ninja/bulk-sync/")
    print(f"   - Status: GET /api/invoice-ninja/status/{user.id}/")
    
    return user, payload

def test_environment_configuration():
    """Test environment configuration for webhooks"""
    print_section("Testing Environment Configuration")
    
    required_vars = [
        'INVOICE_NINJA_WEBHOOK_URL',
        'INVOICE_NINJA_WEBHOOK_SECRET',
    ]
    
    optional_vars = [
        'INVOICE_NINJA_WEBHOOK_TIMEOUT',
        'INVOICE_NINJA_MAX_SYNC_ATTEMPTS',
        'INVOICE_NINJA_API_URL',
        'INVOICE_NINJA_API_TOKEN',
    ]
    
    print("Environment Variables Status:")
    print("-" * 40)
    
    for var in required_vars:
        value = os.getenv(var)
        status = "✓ SET" if value else "✗ MISSING (REQUIRED)"
        display_value = value[:50] + "..." if value and len(value) > 50 else value
        print(f"{var:35} {status:20} {display_value or 'None'}")
    
    for var in optional_vars:
        value = os.getenv(var)
        status = "✓ SET" if value else "- DEFAULT"
        display_value = value[:50] + "..." if value and len(value) > 50 else value
        print(f"{var:35} {status:20} {display_value or 'None'}")
    
    # Test webhook URL accessibility
    webhook_url = os.getenv('INVOICE_NINJA_WEBHOOK_URL')
    if webhook_url and not webhook_url.startswith('https://your-'):
        print(f"\nTesting webhook URL accessibility: {webhook_url}")
        try:
            import requests
            response = requests.get(webhook_url, timeout=5)
            print(f"Webhook URL response: {response.status_code}")
        except requests.exceptions.RequestException as e:
            print(f"Webhook URL test failed: {e}")
        except ImportError:
            print("Requests library not available for URL testing")
    else:
        print(f"\nWebhook URL not configured for testing: {webhook_url}")

def main():
    """Run all tests"""
    print_section("Invoice Ninja Integration Testing Suite")
    print(f"Test started at: {datetime.now()}")
    
    try:
        # Test 1: Environment
        test_environment_configuration()
        
        # Test 2: Data serialization
        test_user_data_serialization()
        
        # Test 3: Webhook payload
        user1 = test_webhook_payload_structure()
        
        # Test 4: Sync status management
        user2 = test_sync_status_management()
        
        # Test 5: Django view simulation
        user3 = simulate_signup_via_django_view()
        
        # Test 6: Webhook analysis
        user4, payload = analyze_webhook_requirements()
        
        print_section("Test Summary")
        created_users = [u for u in [user1, user2, user3, user4] if u]
        print(f"Created {len(created_users)} test users:")
        for user in created_users:
            print(f"- {user.email} (ID: {user.id}) - Status: {user.invoiceninja_sync_status}")
        
        print(f"\nNext Steps:")
        print("1. Configure webhook URL in .env file")
        print("2. Set up n8n workflow or FastAPI service") 
        print("3. Test with webhook.site first for debugging")
        print("4. Monitor Django logs for webhook attempts")
        print("5. Use management commands for monitoring and retry")
        
    except Exception as e:
        print(f"\nTest failed with error: {e}")
        import traceback
        traceback.print_exc()
    
    print(f"\nTest completed at: {datetime.now()}")

if __name__ == "__main__":
    main()
