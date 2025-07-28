#!/usr/bin/env python
"""
Test script to validate flights app URLs and views
"""
import os
import sys
import django

# Add the project root to Python path
project_root = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, project_root)

# Set Django settings
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'core.settings')
django.setup()

from django.urls import reverse, NoReverseMatch
from django.test import RequestFactory
from flights import views

# Test URL patterns
test_urls = [
    # Main flights URLs
    ('flights:index', 'flights/'),
    ('flights:demo', 'flights/demo/'),
    
    # Original flight booking system templates
    ('flights:flight_index', 'flights/original/'),
    ('flights:flight_search', 'flights/original/search/'),
    ('flights:flight_book', 'flights/original/book/'),
    ('flights:flight_bookings', 'flights/original/bookings/'),
    ('flights:flight_payment', 'flights/original/payment/'),
    ('flights:flight_ticket', 'flights/original/ticket/'),
    ('flights:flight_login', 'flights/original/login/'),
    ('flights:flight_register', 'flights/original/register/'),
    ('flights:flight_about', 'flights/original/about/'),
    ('flights:flight_contact', 'flights/original/contact/'),
    
    # New theme templates
    ('flights:new_index', 'flights/new/'),
    ('flights:new_about', 'flights/new/about/'),
    ('flights:new_contact', 'flights/new/contact/'),
    ('flights:new_services', 'flights/new/services/'),
    ('flights:new_elements', 'flights/new/elements/'),
    ('flights:new_index_api', 'flights/new/index-api/'),
]

print("Testing flights app URL patterns...")
print("=" * 50)

success_count = 0
total_count = len(test_urls)

for url_name, expected_path in test_urls:
    try:
        resolved_url = reverse(url_name)
        if expected_path in resolved_url:
            print(f"✅ {url_name}: {resolved_url}")
            success_count += 1
        else:
            print(f"⚠️  {url_name}: {resolved_url} (expected to contain '{expected_path}')")
    except NoReverseMatch as e:
        print(f"❌ {url_name}: URL reverse failed - {e}")
    except Exception as e:
        print(f"❌ {url_name}: Error - {e}")

print("=" * 50)
print(f"URL Test Results: {success_count}/{total_count} URLs working correctly")

# Test if views are properly defined
print("\nTesting view functions...")
print("=" * 30)

view_functions = [
    'index', 'demo', 'flight_index', 'flight_search', 'flight_book',
    'flight_bookings', 'flight_payment', 'flight_ticket', 'flight_login',
    'flight_register', 'flight_about', 'flight_contact', 'new_index',
    'new_about', 'new_contact', 'new_services', 'new_elements', 'new_index_api'
]

view_success = 0
for view_name in view_functions:
    if hasattr(views, view_name):
        print(f"✅ views.{view_name} exists")
        view_success += 1
    else:
        print(f"❌ views.{view_name} missing")

print("=" * 30)
print(f"View Test Results: {view_success}/{len(view_functions)} views defined correctly")

# Summary
if success_count == total_count and view_success == len(view_functions):
    print("\n🎉 ALL TESTS PASSED! Flights app is ready to use.")
else:
    print(f"\n⚠️  Some issues found. URLs: {success_count}/{total_count}, Views: {view_success}/{len(view_functions)}")
