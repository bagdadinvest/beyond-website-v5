#!/usr/bin/env python
"""
Test script for N/A error handling in the invoice system
"""
import os
import sys
import django

# Add the project root to Python path
sys.path.insert(0, '/root/Downloads/beyond-website-main')

# Configure Django settings
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'core.settings')
django.setup()

from django.test import RequestFactory
from django.contrib.auth import get_user_model
from django.contrib.sessions.backends.db import SessionStore
from apps.views import book_flight_enhanced

def test_na_error_handling():
    """Test the N/A error handling functionality"""
    print("=== TESTING N/A ERROR HANDLING ===")
    
    # Set up test components
    factory = RequestFactory()
    User = get_user_model()
    
    # Create a test user with valid but minimal data 
    user, created = User.objects.get_or_create(
        username='errorhandletest',
        defaults={
            'email': 'test@example.com',
            'first_name': 'Test',
            'last_name': 'User',
        }
    )
    
    # Simulate missing data by setting attributes to empty/None after creation
    if not created:
        user.email = ''
        user.first_name = ''
        # Don't save to database, just test in memory for error handling
    
    print(f"Test user: {user.username} (created: {created})")
    print(f"User email: '{user.email}' (simulated empty for N/A test)")
    print(f"User first_name: '{user.first_name}' (simulated empty for N/A test)")
    
    # Create POST request with MISSING flight data
    request = factory.post('/apps/book_flight_enhanced/', {
        # Intentionally missing some fields to test error handling
        'departure': '',  # Empty departure
        'arrival': None,  # Missing arrival
        # Missing passengers, dates, etc.
    })
    
    # Add user and session to request
    request.user = user
    session = SessionStore()
    session.create()
    request.session = session
    
    print("\nTesting with missing/empty data...")
    try:
        # Test web invoice with missing data
        response = book_flight_enhanced(request, flight=None)
        print(f"Response status: {response.status_code}")
        
        if response.status_code == 200:
            print("✓ Web invoice handled missing data successfully!")
            
            # Check if response contains "N/A" fallbacks
            content = response.content.decode('utf-8', errors='ignore')
            if 'N/A' in content or 'Guest User' in content or 'not-provided@example.com' in content:
                print("✓ N/A error handling working - fallback values found in response!")
            else:
                print("⚠ Warning: No fallback values found, might need to check template")
        else:
            print(f"✗ Unexpected status code: {response.status_code}")
            
    except Exception as e:
        print(f"✗ Error during test: {e}")
        import traceback
        traceback.print_exc()
    
    print("\nTesting PDF generation with missing data...")
    try:
        # Test PDF with missing data
        request.GET = request.GET.copy()
        request.GET['format'] = 'pdf'
        
        pdf_response = book_flight_enhanced(request, flight=None)
        print(f"PDF response status: {pdf_response.status_code}")
        
        if hasattr(pdf_response, 'content'):
            if 'application/pdf' in str(pdf_response.get('Content-Type', '')):
                print("✓ PDF generated successfully with missing data!")
                print(f"PDF size: {len(pdf_response.content)} bytes")
            else:
                print("PDF generation fell back to web view (this is expected)")
                content = pdf_response.content.decode('utf-8', errors='ignore')
                if 'N/A' in content or 'Guest User' in content:
                    print("✓ Fallback web view contains N/A handling!")
        
    except Exception as e:
        print(f"✗ PDF test error: {e}")
    
    print("\n=== N/A ERROR HANDLING TEST COMPLETE ===")

if __name__ == '__main__':
    test_na_error_handling()
