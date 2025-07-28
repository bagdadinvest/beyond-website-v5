#!/usr/bin/env python
"""
Test script for PDF generation functionality
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

def test_pdf_generation():
    """Test the PDF generation functionality"""
    
    # Set up test components
    factory = RequestFactory()
    User = get_user_model()
    
    # Create or get test user
    user, created = User.objects.get_or_create(
        username='pdftestuser',
        defaults={
            'email': 'pdftest@example.com',
            'first_name': 'PDF',
            'last_name': 'Tester'
        }
    )
    
    print(f"Using user: {user.username} (created: {created})")
    
    # Create POST request with flight data
    request = factory.post('/apps/book_flight_enhanced/', {
        'departure': 'LHR',
        'arrival': 'JFK',
        'departure_date': '2024-12-30',
        'return_date': '2025-01-15',
        'passengers': '2'
    })
    
    # Add user and session to request
    request.user = user
    session = SessionStore()
    session.create()
    request.session = session
    
    print("Testing web invoice generation...")
    try:
        # Test web invoice first
        response = book_flight_enhanced(request)
        print(f"Web invoice status: {response.status_code}")
        
        if response.status_code == 200:
            print("✓ Web invoice generation successful")
        else:
            print(f"✗ Web invoice failed with status {response.status_code}")
            
    except Exception as e:
        print(f"✗ Web invoice error: {e}")
        
    print("\nTesting PDF generation...")
    try:
        # Test PDF generation
        request.GET = request.GET.copy()
        request.GET['format'] = 'pdf'
        
        pdf_response = book_flight_enhanced(request)
        print(f"PDF response status: {pdf_response.status_code}")
        print(f"PDF Content-Type: {pdf_response.get('Content-Type', 'Not set')}")
        
        if hasattr(pdf_response, 'content'):
            print(f"PDF response size: {len(pdf_response.content)} bytes")
            
            if 'application/pdf' in str(pdf_response.get('Content-Type', '')):
                print("✓ PDF generation successful!")
                
                # Save PDF to file for verification
                with open('test_invoice.pdf', 'wb') as f:
                    f.write(pdf_response.content)
                print("✓ PDF saved as test_invoice.pdf")
                
            else:
                print("✗ Response is not a PDF")
                # Show content preview if it's not a PDF
                content_preview = pdf_response.content[:500].decode('utf-8', errors='ignore')
                print(f"Content preview: {content_preview}")
        else:
            print("✗ No content in response")
            
    except Exception as e:
        print(f"✗ PDF generation error: {e}")
        import traceback
        traceback.print_exc()

if __name__ == '__main__':
    test_pdf_generation()
