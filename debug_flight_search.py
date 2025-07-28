#!/usr/bin/env python3
"""
Comprehensive debugging script to test both old and new flight search setups
"""
import os
import sys
from pathlib import Path

# Add the project directory to the Python path
project_dir = Path(__file__).parent
sys.path.insert(0, str(project_dir))

# Set up Django environment
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'core.settings')

try:
    import django
    django.setup()
    
    print("🔧 Flight Search Setup Debugging Tool")
    print("=" * 50)
    
    # Test settings
    from django.conf import settings
    print(f"✅ Django settings loaded")
    print(f"   AMADEUS_CLIENT_ID: {getattr(settings, 'AMADEUS_CLIENT_ID', 'NOT SET')[:8]}...")
    print(f"   AMADEUS_CLIENT_SECRET: {'*' * len(getattr(settings, 'AMADEUS_CLIENT_SECRET', ''))} chars")
    
    # Test both Amadeus clients
    print("\n🔍 Testing Amadeus Client Initialization")
    print("-" * 40)
    
    try:
        from apps.views import amadeus as old_amadeus
        print(f"✅ OLD SETUP (apps/views.py) - Client initialized")
        print(f"   Client ID: {old_amadeus.client_id[:8]}...")
        print(f"   Client Secret: {'*' * len(old_amadeus.client_secret)} chars")
    except Exception as e:
        print(f"❌ OLD SETUP - Error: {e}")
    
    try:
        from flights.views import amadeus as new_amadeus
        print(f"✅ NEW SETUP (flights/views.py) - Client initialized")
        print(f"   Client ID: {new_amadeus.client_id[:8]}...")
        print(f"   Client Secret: {'*' * len(new_amadeus.client_secret)} chars")
    except Exception as e:
        print(f"❌ NEW SETUP - Error: {e}")
    
    # Compare clients
    print("\n⚖️  Client Comparison")
    print("-" * 20)
    try:
        if old_amadeus.client_id == new_amadeus.client_id:
            print("✅ Client IDs match")
        else:
            print("❌ Client IDs differ!")
            print(f"   Old: {old_amadeus.client_id}")
            print(f"   New: {new_amadeus.client_id}")
            
        if old_amadeus.client_secret == new_amadeus.client_secret:
            print("✅ Client Secrets match")
        else:
            print("❌ Client Secrets differ!")
    except:
        print("❌ Could not compare clients")
    
    # Test actual API call
    print("\n🌐 Testing API Connection")
    print("-" * 25)
    
    try:
        from amadeus.reference_data.locations import Location
        
        # Test with old client
        print("Testing OLD setup API call...")
        response_old = old_amadeus.reference_data.locations.get(
            keyword='NYC',
            subType=Location.AIRPORT
        )
        print(f"✅ OLD setup - API call successful, found {len(response_old.data)} airports")
        
        # Test with new client  
        print("Testing NEW setup API call...")
        response_new = new_amadeus.reference_data.locations.get(
            keyword='NYC', 
            subType=Location.AIRPORT
        )
        print(f"✅ NEW setup - API call successful, found {len(response_new.data)} airports")
        
    except Exception as e:
        print(f"❌ API test failed: {e}")
    
    # Check URL routing
    print("\n🛤️  URL Routing Check")
    print("-" * 20)
    
    try:
        from django.urls import reverse
        old_url = reverse('app:demo')  # Assuming this is the old URL
        print(f"✅ Old URL: {old_url}")
    except:
        print("❌ Could not resolve old URL")
        
    try:
        new_url = reverse('flights:new_index')
        print(f"✅ New URL: {new_url}")
    except Exception as e:
        print(f"❌ Could not resolve new URL: {e}")
    
    # Check templates
    print("\n📄 Template Check")
    print("-" * 15)
    
    template_paths = [
        'demo/home.html',
        'demo/results.html', 
        'new/index.html',
        'flights/partials/flight_search_form.html'
    ]
    
    for template_path in template_paths:
        full_path = project_dir / 'templates' / template_path
        flights_path = project_dir / 'flights' / 'templates' / template_path
        apps_path = project_dir / 'apps' / 'templates' / template_path
        
        if full_path.exists():
            print(f"✅ {template_path} found in templates/")
        elif flights_path.exists():
            print(f"✅ {template_path} found in flights/templates/")
        elif apps_path.exists():
            print(f"✅ {template_path} found in apps/templates/")
        else:
            print(f"❌ {template_path} NOT FOUND")
    
    print("\n📋 Next Steps for Debugging:")
    print("-" * 30)
    print("1. Try accessing old working URL (likely /demo/ or /app/demo/)")
    print("2. Try accessing new URL (/flights/new/)")
    print("3. Submit forms and check server logs for debug output")
    print("4. Compare the debug output from both setups")
    print("5. Check browser network tab for failed requests")
    
    print("\n🔧 Debug Commands:")
    print("- OLD setup: Check logs when submitting form at old URL")
    print("- NEW setup: Check logs when submitting form at /flights/new/")
    print("- Look for '=== OLD WORKING SETUP DEBUG ===' messages")
    print("- Look for '=== NEW SETUP DEBUG ===' messages")

except Exception as e:
    print(f"❌ Setup error: {e}")
    import traceback
    traceback.print_exc()
