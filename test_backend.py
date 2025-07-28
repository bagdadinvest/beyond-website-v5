#!/usr/bin/env python
"""
Simple test script to check if the authentication backends are working correctly
"""
import os
import sys
import django

# Setup Django environment
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'core.settings')
sys.path.append('/root/Downloads/beyond-website-main')

try:
    django.setup()
    
    from django.contrib.auth import get_user_model, authenticate
    from django.conf import settings
    
    User = get_user_model()
    
    print("=== BACKEND CONFIGURATION TEST ===")
    print(f"Authentication backends: {settings.AUTHENTICATION_BACKENDS}")
    print(f"Total users in database: {User.objects.count()}")
    
    # Test if we can get a user
    if User.objects.exists():
        test_user = User.objects.first()
        print(f"First user: {test_user.email} (active: {test_user.is_active})")
        
        # Test authentication
        print("\n=== AUTHENTICATION TEST ===")
        print("Testing authentication with email...")
        
        # Note: We can't test actual password authentication without knowing a password
        # But we can test the backend structure
        auth_result = authenticate(username=test_user.email, password="wrong_password")
        print(f"Authentication result (expected None): {auth_result}")
        
    else:
        print("No users found in database")
    
    print("\n=== BACKEND IMPORT TEST ===")
    try:
        from apps.backends import EmailBackend
        backend = EmailBackend()
        print("✓ EmailBackend imported successfully")
        print(f"✓ Backend methods: {[method for method in dir(backend) if not method.startswith('_')]}")
    except ImportError as e:
        print(f"✗ Failed to import EmailBackend: {e}")
    
    print("\n=== SETTINGS TEST ===")
    print(f"Account email verification: {getattr(settings, 'ACCOUNT_EMAIL_VERIFICATION', 'not set')}")
    print(f"Account authentication method: {getattr(settings, 'ACCOUNT_AUTHENTICATION_METHOD', 'not set')}")
    print(f"Account username required: {getattr(settings, 'ACCOUNT_USERNAME_REQUIRED', 'not set')}")
    
except Exception as e:
    print(f"Error during test: {e}")
    import traceback
    traceback.print_exc()
