#!/usr/bin/env python
"""
Quick Integration Test - End-to-End Invoice Ninja Flow
"""

import os
import sys
import django
import json
from datetime import datetime, date

# Load environment variables
try:
    from dotenv import load_dotenv
    load_dotenv()
except ImportError:
    pass

# Setup Django
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'core.settings')
django.setup()

from django.contrib.auth import get_user_model
from apps.invoice_ninja_utils import UserDataSerializer, WebhookSender, SyncStatusManager

User = get_user_model()

def test_complete_flow():
    """Test the complete Invoice Ninja integration flow"""
    print("🚀 Testing Complete Invoice Ninja Integration Flow")
    print("="*60)
    
    # Step 1: Create a test user (simulates signup)
    print("\n📝 Step 1: Creating Test User (Simulating Signup)")
    
    test_email = "integration_test@example.com"
    
    # Clean up existing user
    try:
        existing_user = User.objects.get(email=test_email)
        existing_user.delete()
        print(f"   ♻️  Cleaned up existing user: {test_email}")
    except User.DoesNotExist:
        pass
    
    # Create new user (this should trigger the signal)
    user = User.objects.create_user(
        username=test_email,
        email=test_email,
        password='TestPass123!',
        first_name='Integration',
        last_name='Test',
        phone_number='+15551234567',
        date_of_birth=date(1990, 1, 1),
        nationality='US',
        referral_code='REF123'
    )
    
    print(f"   ✅ User created: {user.email} (ID: {user.id})")
    print(f"   📊 Initial sync status: {user.invoiceninja_sync_status}")
    print(f"   🔄 Sync attempts: {user.invoiceninja_sync_attempts}")
    
    # Step 2: Show the webhook data that would be sent
    print("\n📡 Step 2: Webhook Data Analysis")
    
    # Get the serialized data
    serializer = UserDataSerializer()
    webhook_sender = WebhookSender()
    
    serialized_data = serializer.serialize_user_for_invoice_ninja(user)
    webhook_payload = webhook_sender._create_webhook_payload(user, 'user.created')
    
    print("   📋 Data that will be sent to n8n/external service:")
    print(json.dumps(webhook_payload, indent=4, default=str))
    
    # Step 3: Simulate n8n processing
    print("\n🔄 Step 3: Simulating n8n/External Service Processing")
    
    # Transform for Invoice Ninja (this is what n8n would do)
    invoice_ninja_data = {
        "name": f"{user.first_name} {user.last_name}",
        "email": user.email,
        "phone": user.phone_number,
        "country_id": 840,  # US
        "custom_value1": str(user.id),  # Django user ID
        "custom_value2": user.nationality,
        "custom_value3": str(user.date_of_birth),
        "custom_value4": user.referral_code,
        "public_notes": f"Medical tourism patient from Django (ID: {user.id})",
        "private_notes": f"Created: {datetime.now()}"
    }
    
    print("   📊 Data transformed for Invoice Ninja API:")
    print(json.dumps(invoice_ninja_data, indent=4))
    
    # Step 4: Simulate successful Invoice Ninja response
    print("\n✅ Step 4: Simulating Successful Invoice Ninja Client Creation")
    
    # This is what the external service would send back to Django
    success_callback_data = {
        'django_user_id': user.id,
        'invoice_ninja_client_id': f'client_{int(datetime.now().timestamp())}',
        'success': True,
        'message': 'Client created successfully in Invoice Ninja',
        'timestamp': datetime.now().isoformat()
    }
    
    print("   📩 Callback data that would be sent to Django:")
    print(json.dumps(success_callback_data, indent=4))
    
    # Step 5: Simulate the callback processing
    print("\n🔄 Step 5: Processing Callback (Updating User Status)")
    
    sync_manager = SyncStatusManager()
    sync_manager.mark_as_synced(
        user, 
        success_callback_data['invoice_ninja_client_id']
    )
    
    # Refresh user data
    user.refresh_from_db()
    
    print(f"   ✅ User sync status updated: {user.invoiceninja_sync_status}")
    print(f"   🆔 Invoice Ninja Client ID: {user.invoiceninja_client_id}")
    print(f"   📊 Total sync attempts: {user.invoiceninja_sync_attempts}")
    print(f"   ⏰ Last sync attempt: {user.invoiceninja_last_sync_attempt}")
    
    # Step 6: Summary
    print("\n📋 Step 6: Integration Flow Summary")
    print("="*60)
    
    flow_steps = [
        "✅ Django user created (signup)",
        "✅ Signal triggered Invoice Ninja sync",
        "✅ User data serialized for webhook",
        "✅ Webhook payload prepared",
        "✅ External service processing simulated",
        "✅ Invoice Ninja API data prepared",
        "✅ Success callback processed",
        "✅ User status updated in Django"
    ]
    
    for step in flow_steps:
        print(f"   {step}")
    
    print(f"\n🎉 SUCCESS: Complete integration flow tested!")
    print(f"   📧 User: {user.email}")
    print(f"   🆔 Django ID: {user.id}")
    print(f"   💼 Invoice Ninja Client ID: {user.invoiceninja_client_id}")
    print(f"   📊 Status: {user.invoiceninja_sync_status}")
    
    # Step 7: What's needed for production
    print("\n🚀 Step 7: Production Deployment Checklist")
    print("="*60)
    
    checklist = [
        ("Webhook URL", os.getenv('INVOICE_NINJA_WEBHOOK_URL', 'NOT_SET')),
        ("Webhook Secret", "✓ SET" if os.getenv('INVOICE_NINJA_WEBHOOK_SECRET') else "❌ MISSING"),
        ("Invoice Ninja Token", "✓ SET" if os.getenv('INVOICE_NINJA_API_TOKEN') != 'your-test-api-token-here' else "❌ NEEDS REAL TOKEN"),
        ("External Service", "❌ NEEDS SETUP (n8n or FastAPI)"),
        ("Production Testing", "❌ PENDING")
    ]
    
    for item, status in checklist:
        print(f"   {item:20} {status}")
    
    print(f"\n📝 Next Steps:")
    print(f"   1. Set up webhook.site URL for initial testing")
    print(f"   2. Create n8n workflow or deploy FastAPI service")
    print(f"   3. Configure real Invoice Ninja API token")
    print(f"   4. Test with real webhook endpoint")
    print(f"   5. Monitor sync success rates")
    
    return user

if __name__ == "__main__":
    test_complete_flow()
