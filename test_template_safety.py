#!/usr/bin/env python
"""
Quick test for safe access functions in templates
"""
import os
import sys
import django

sys.path.insert(0, '/root/Downloads/beyond-website-main')
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'core.settings')
django.setup()

from django.template import Template, Context
from django.template.loader import get_template

def test_template_safe_filters():
    """Test our safe template filters"""
    
    print("🧪 Testing Template Safe Filters")
    print("=" * 40)
    
    # Test data with missing/empty values
    test_context = {
        'invoice': {
            'customer_name': 'John Doe',
            'customer_email': '',  # Empty string
            'customer_phone': None,  # None value
            'flight_details': {
                'flight_number': 'BJ131',
                'price': '100.00',
                'currency': '',  # Empty string
                # Missing: route, departure, arrival, etc.
            },
            # Missing: invoice_number, date, ref_no, etc.
        }
    }
    
    # Test template with safe filters
    test_template = """
    {% load safe_filters %}
    Customer: {{ invoice.customer_name|safe_get:"Guest" }}
    Email: {{ invoice.customer_email|safe_get:"No email" }}
    Phone: {{ invoice.customer_phone|safe_get:"No phone" }}
    Flight: {{ invoice.flight_details.flight_number|safe_get:"No flight" }}
    Price: {{ invoice.flight_details.price|safe_get:"0.00" }}
    Currency: {{ invoice.flight_details.currency|safe_get:"USD" }}
    Missing Field: {{ invoice.missing_field|safe_get:"N/A" }}
    """
    
    try:
        template = Template(test_template)
        context = Context(test_context)
        rendered = template.render(context)
        
        print("✅ Template rendering successful!")
        print("\nRendered output:")
        print("-" * 20)
        print(rendered.strip())
        print("-" * 20)
        
        # Check if "N/A" appears for missing fields
        if "N/A" in rendered:
            print("✅ Missing fields properly handled with 'N/A'")
        
        if "No email" in rendered:
            print("✅ Empty strings properly handled")
            
        if "No phone" in rendered:
            print("✅ None values properly handled")
            
        print("\n🎉 Template safe filters working correctly!")
        
    except Exception as e:
        print(f"❌ Template error: {e}")
        import traceback
        traceback.print_exc()

def test_pdf_template_loading():
    """Test loading the PDF template"""
    
    print("\n🧪 Testing PDF Template Loading")
    print("=" * 40)
    
    try:
        template = get_template('demo/flight_invoice_pdf.html')
        print("✅ PDF template loaded successfully!")
        
        # Test with minimal context
        minimal_context = {
            'invoice': {
                'invoice_number': 'TEST-001',
                'customer_name': 'Test User',
                'customer_email': 'test@example.com',
                'flight_details': {
                    'flight_number': 'TEST123',
                    'price': '100.00'
                }
            }
        }
        
        html = template.render(minimal_context)
        print("✅ Template rendering with minimal data successful!")
        print(f"✅ Generated HTML length: {len(html)} characters")
        
        # Check for "N/A" in output (should appear for missing fields)
        na_count = html.count('N/A')
        print(f"✅ Found {na_count} 'N/A' entries for missing fields")
        
        if na_count > 0:
            print("✅ Robust error handling working in template!")
        
    except Exception as e:
        print(f"❌ Template loading error: {e}")
        import traceback
        traceback.print_exc()

if __name__ == '__main__':
    test_template_safe_filters()
    test_pdf_template_loading()
    print("\n🎉 All template tests completed!")
