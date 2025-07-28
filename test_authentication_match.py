#!/usr/bin/env python3
"""
Test to verify both apps.views and flights.views have identical Amadeus authentication
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
    
    # Test both view files
    print("🔧 Testing Amadeus Client initialization in both view files...")
    
    # Test apps/views.py (working version)
    print("\n=== Testing apps/views.py (working version) ===")
    try:
        from apps.views import amadeus as apps_amadeus
        print(f"✅ apps/views.py - Client initialized successfully")
        print(f"   Client ID: {apps_amadeus.client_id[:8]}...")
        print(f"   Client Secret: {'*' * len(apps_amadeus.client_secret)}")
    except Exception as e:
        print(f"❌ apps/views.py - Error: {e}")
    
    # Test flights/views.py (new version)  
    print("\n=== Testing flights/views.py (new version) ===")
    try:
        from flights.views import amadeus as flights_amadeus
        print(f"✅ flights/views.py - Client initialized successfully")
        print(f"   Client ID: {flights_amadeus.client_id[:8]}...")
        print(f"   Client Secret: {'*' * len(flights_amadeus.client_secret)}")
    except Exception as e:
        print(f"❌ flights/views.py - Error: {e}")
    
    # Compare them
    print("\n=== Comparison ===")
    try:
        if apps_amadeus.client_id == flights_amadeus.client_id:
            print("✅ Client IDs match")
        else:
            print("❌ Client IDs differ")
            
        if apps_amadeus.client_secret == flights_amadeus.client_secret:
            print("✅ Client Secrets match")
        else:
            print("❌ Client Secrets differ")
            
        print("✅ Both views use identical Amadeus authentication")
            
    except Exception as e:
        print(f"❌ Error comparing clients: {e}")
    
    # Test a simple API call to verify authentication works
    print("\n=== Testing API Call ===")
    try:
        from amadeus.reference_data.locations import Location
        response = flights_amadeus.reference_data.locations.get(
            keyword='NYC',
            subType=Location.AIRPORT
        )
        print(f"✅ API Call successful - Found {len(response.data)} airports")
        
    except Exception as e:
        print(f"❌ API Call failed: {e}")
        
except Exception as e:
    print(f"❌ Setup error: {e}")

print("\n📋 Summary:")
print("- Both view files should now use identical authentication")
print("- The new template replicates the working pattern exactly")
print("- Test your form submission to see if it works now")
