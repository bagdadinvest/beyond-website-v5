#!/usr/bin/env python3
"""
Amadeus API Credentials Test Script
This script tests the Amadeus API credentials to ensure they're working correctly.
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
    
    from django.conf import settings
    from amadeus import Client, ResponseError
    from amadeus.reference_data.locations import Location
    
    print("🔧 Testing Amadeus API Credentials...")
    print(f"Client ID: {settings.AMADEUS_CLIENT_ID[:8]}..." if settings.AMADEUS_CLIENT_ID else "Not set")
    print(f"Client Secret: {'*' * len(settings.AMADEUS_CLIENT_SECRET) if settings.AMADEUS_CLIENT_SECRET else 'Not set'}")
    
    # Initialize Amadeus client
    amadeus = Client(
        client_id=settings.AMADEUS_CLIENT_ID,
        client_secret=settings.AMADEUS_CLIENT_SECRET
    )
    
    print("\n🔍 Testing API connection with a simple location search...")
    try:
        # Test the API with a simple location search
        response = amadeus.reference_data.locations.get(
            keyword='NYC',
            subType=Location.AIRPORT
        )
        
        if response.data:
            print("✅ API Connection Successful!")
            print(f"Found {len(response.data)} airports for 'NYC'")
            for airport in response.data[:3]:  # Show first 3 results
                print(f"  - {airport['iataCode']}: {airport['name']}")
        else:
            print("⚠️  API connected but no data returned")
            
    except ResponseError as error:
        print(f"❌ API Error: {error}")
        if error.response.status_code == 401:
            print("   This usually means invalid credentials")
        elif error.response.status_code == 403:
            print("   This usually means insufficient permissions")
        else:
            print(f"   HTTP Status: {error.response.status_code}")
            
    except Exception as e:
        print(f"❌ Unexpected error: {e}")
        
except ImportError as e:
    print(f"❌ Import error: {e}")
    print("Make sure Django and all dependencies are installed")
except Exception as e:
    print(f"❌ Setup error: {e}")

print("\n📋 Credential Setup:")
print("1. Current credentials are in .env file")
print("2. Default test credentials are temporarily being used")
print("3. For production, get new credentials from: https://developers.amadeus.com/")
print("4. Replace AMADEUS_CLIENT_ID and AMADEUS_CLIENT_SECRET in .env file")
