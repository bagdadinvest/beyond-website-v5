#!/usr/bin/env python
"""
Django Callback Testing Script
Tests the Django callback endpoints that receive responses from n8n/external services
"""

import os
import sys
import django
import json
import requests
from datetime import datetime

# Setup Django
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'core.settings')
django.setup()

from django.test import Client
from django.contrib.auth import get_user_model
from django.urls import reverse

User = get_user_model()

class DjangoCallbackTester:
    """Test Django callback endpoints"""
    
    def __init__(self):
        self.client = Client()
        self.webhook_secret = os.getenv('INVOICE_NINJA_WEBHOOK_SECRET', 'test-secret-123')
        self.base_url = 'http://localhost:8000'
    
    def create_test_user(self, email_suffix=""):
        """Create a test user for callback testing"""
        email = f"callback_test{email_suffix}@example.com"
        
        # Clean up existing user
        try:
            existing_user = User.objects.get(email=email)
            existing_user.delete()
        except User.DoesNotExist:
            pass
        
        user = User.objects.create_user(
            username=email,
            email=email,
            password='TestPass123!',
            first_name='Callback',
            last_name='Test',
            phone_number='+1-555-0123'
        )
        
        # Set to pending sync status
        user.invoiceninja_sync_status = 'pending'
        user.invoiceninja_sync_attempts = 1
        user.save()
        
        return user
    
    def test_successful_callback(self):
        """Test successful client creation callback"""
        print("\n--- Testing Successful Callback ---")
        
        # Create test user
        user = self.create_test_user("_success")
        print(f"Created test user: {user.email} (ID: {user.id})")
        print(f"Initial sync status: {user.invoiceninja_sync_status}")
        
        # Prepare callback data
        callback_data = {
            'django_user_id': user.id,
            'invoice_ninja_client_id': 'client_test_12345',
            'success': True,
            'message': 'Client created successfully in Invoice Ninja',
            'timestamp': datetime.now().isoformat()
        }
        
        print(f"Callback data: {json.dumps(callback_data, indent=2)}")
        
        # Send callback
        response = self.client.post(
            '/api/invoice-ninja/client-created/',
            data=json.dumps(callback_data),
            content_type='application/json',
            HTTP_X_WEBHOOK_SECRET=self.webhook_secret
        )
        
        print(f"Response status: {response.status_code}")
        print(f"Response content: {response.content.decode()}")
        
        # Check user status after callback
        user.refresh_from_db()
        print(f"Updated sync status: {user.invoiceninja_sync_status}")
        print(f"Client ID: {user.invoiceninja_client_id}")
        
        return response.status_code == 200 and user.invoiceninja_sync_status == 'synced'
    
    def test_failed_callback(self):
        """Test failed client creation callback"""
        print("\n--- Testing Failed Callback ---")
        
        # Create test user
        user = self.create_test_user("_failed")
        print(f"Created test user: {user.email} (ID: {user.id})")
        
        # Prepare failure callback data
        callback_data = {
            'django_user_id': user.id,
            'success': False,
            'error': 'Email already exists',
            'error_code': 'EMAIL_DUPLICATE',
            'retry': False,
            'message': 'Email already exists in Invoice Ninja',
            'timestamp': datetime.now().isoformat()
        }
        
        print(f"Callback data: {json.dumps(callback_data, indent=2)}")
        
        # Send callback
        response = self.client.post(
            '/api/invoice-ninja/client-created/',
            data=json.dumps(callback_data),
            content_type='application/json',
            HTTP_X_WEBHOOK_SECRET=self.webhook_secret
        )
        
        print(f"Response status: {response.status_code}")
        print(f"Response content: {response.content.decode()}")
        
        # Check user status after callback
        user.refresh_from_db()
        print(f"Updated sync status: {user.invoiceninja_sync_status}")
        print(f"Sync attempts: {user.invoiceninja_sync_attempts}")
        
        return response.status_code == 200 and user.invoiceninja_sync_status == 'failed'
    
    def test_retry_callback(self):
        """Test callback that should trigger retry"""
        print("\n--- Testing Retry Callback ---")
        
        # Create test user
        user = self.create_test_user("_retry")
        print(f"Created test user: {user.email} (ID: {user.id})")
        
        # Prepare retry callback data
        callback_data = {
            'django_user_id': user.id,
            'success': False,
            'error': 'API temporarily unavailable',
            'error_code': 'API_ERROR',
            'retry': True,
            'message': 'Invoice Ninja API is temporarily unavailable',
            'timestamp': datetime.now().isoformat()
        }
        
        print(f"Callback data: {json.dumps(callback_data, indent=2)}")
        
        # Send callback
        response = self.client.post(
            '/api/invoice-ninja/client-created/',
            data=json.dumps(callback_data),
            content_type='application/json',
            HTTP_X_WEBHOOK_SECRET=self.webhook_secret
        )
        
        print(f"Response status: {response.status_code}")
        print(f"Response content: {response.content.decode()}")
        
        # Check user status after callback
        user.refresh_from_db()
        print(f"Updated sync status: {user.invoiceninja_sync_status}")
        print(f"Sync attempts: {user.invoiceninja_sync_attempts}")
        
        return response.status_code == 200 and user.invoiceninja_sync_status == 'retry'
    
    def test_bulk_callback(self):
        """Test bulk sync callback"""
        print("\n--- Testing Bulk Callback ---")
        
        # Create multiple test users
        users = []
        for i in range(3):
            user = self.create_test_user(f"_bulk_{i}")
            users.append(user)
            print(f"Created test user {i+1}: {user.email} (ID: {user.id})")
        
        # Prepare bulk callback data
        callback_data = {
            'batch_id': 'test_batch_001',
            'results': [
                {
                    'django_user_id': users[0].id,
                    'invoice_ninja_client_id': 'client_bulk_1',
                    'success': True,
                    'message': 'Success'
                },
                {
                    'django_user_id': users[1].id,
                    'success': False,
                    'error': 'Email exists',
                    'retry': False
                },
                {
                    'django_user_id': users[2].id,
                    'invoice_ninja_client_id': 'client_bulk_3',
                    'success': True,
                    'message': 'Success'
                }
            ],
            'timestamp': datetime.now().isoformat()
        }
        
        print(f"Bulk callback data: {json.dumps(callback_data, indent=2)}")
        
        # Send bulk callback
        response = self.client.post(
            '/api/invoice-ninja/bulk-sync/',
            data=json.dumps(callback_data),
            content_type='application/json',
            HTTP_X_WEBHOOK_SECRET=self.webhook_secret
        )
        
        print(f"Response status: {response.status_code}")
        print(f"Response content: {response.content.decode()}")
        
        # Check all users' statuses
        success_count = 0
        for i, user in enumerate(users):
            user.refresh_from_db()
            print(f"User {i+1} status: {user.invoiceninja_sync_status}, Client ID: {user.invoiceninja_client_id}")
            if user.invoiceninja_sync_status in ['synced', 'failed']:
                success_count += 1
        
        return response.status_code == 200 and success_count == 3
    
    def test_status_endpoint(self):
        """Test sync status endpoint"""
        print("\n--- Testing Status Endpoint ---")
        
        # Create test user with synced status
        user = self.create_test_user("_status")
        user.invoiceninja_sync_status = 'synced'
        user.invoiceninja_client_id = 'client_status_test'
        user.save()
        
        print(f"Test user: {user.email} (ID: {user.id})")
        
        # Test status endpoint
        response = self.client.get(f'/api/invoice-ninja/status/{user.id}/')
        
        print(f"Response status: {response.status_code}")
        print(f"Response content: {response.content.decode()}")
        
        try:
            response_data = json.loads(response.content.decode())
            print(f"Parsed response: {json.dumps(response_data, indent=2)}")
        except:
            print("Could not parse response as JSON")
        
        return response.status_code == 200
    
    def test_invalid_secret(self):
        """Test callback with invalid webhook secret"""
        print("\n--- Testing Invalid Webhook Secret ---")
        
        user = self.create_test_user("_invalid_secret")
        
        callback_data = {
            'django_user_id': user.id,
            'invoice_ninja_client_id': 'client_test_invalid',
            'success': True
        }
        
        # Send with wrong secret
        response = self.client.post(
            '/api/invoice-ninja/client-created/',
            data=json.dumps(callback_data),
            content_type='application/json',
            HTTP_X_WEBHOOK_SECRET='wrong-secret'
        )
        
        print(f"Response status: {response.status_code}")
        print(f"Response content: {response.content.decode()}")
        
        return response.status_code == 403
    
    def test_missing_user(self):
        """Test callback for non-existent user"""
        print("\n--- Testing Missing User Callback ---")
        
        callback_data = {
            'django_user_id': 99999,  # Non-existent user ID
            'invoice_ninja_client_id': 'client_test_missing',
            'success': True
        }
        
        response = self.client.post(
            '/api/invoice-ninja/client-created/',
            data=json.dumps(callback_data),
            content_type='application/json',
            HTTP_X_WEBHOOK_SECRET=self.webhook_secret
        )
        
        print(f"Response status: {response.status_code}")
        print(f"Response content: {response.content.decode()}")
        
        return response.status_code == 404

def run_all_callback_tests():
    """Run all callback tests"""
    print("="*60)
    print(" DJANGO CALLBACK TESTING SUITE")
    print("="*60)
    
    tester = DjangoCallbackTester()
    
    tests = [
        ('Successful Callback', tester.test_successful_callback),
        ('Failed Callback', tester.test_failed_callback),
        ('Retry Callback', tester.test_retry_callback),
        ('Bulk Callback', tester.test_bulk_callback),
        ('Status Endpoint', tester.test_status_endpoint),
        ('Invalid Secret', tester.test_invalid_secret),
        ('Missing User', tester.test_missing_user),
    ]
    
    results = {}
    
    for test_name, test_func in tests:
        print(f"\n{'='*20} {test_name} {'='*20}")
        try:
            result = test_func()
            results[test_name] = 'PASS' if result else 'FAIL'
            print(f"Result: {results[test_name]}")
        except Exception as e:
            results[test_name] = f'ERROR: {e}'
            print(f"Result: ERROR - {e}")
    
    # Summary
    print("\n" + "="*60)
    print(" TEST SUMMARY")
    print("="*60)
    
    for test_name, result in results.items():
        status_icon = "✓" if result == 'PASS' else "✗"
        print(f"{status_icon} {test_name:25} {result}")
    
    passed = sum(1 for r in results.values() if r == 'PASS')
    total = len(results)
    print(f"\nPassed: {passed}/{total}")
    
    return results

if __name__ == "__main__":
    run_all_callback_tests()
