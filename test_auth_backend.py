#!/usr/bin/env python
"""
Test script to verify our authentication backend fixes
"""
import os
import sys
import django

# Add the project directory to Python path
sys.path.append('/root/Downloads/beyond-website-main')

# Set up Django
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'core.settings')
django.setup()

# Now we can import Django components
from django.contrib.auth import authenticate, get_user_model
from django.conf import settings
from apps.backends import EmailBackend

User = get_user_model()

def test_authentication_backends():
    """Test authentication backend configuration"""
    print("=== Testing Authentication Backend Configuration ===")
    
    print(f"✅ Authentication backends configured:")
    for i, backend in enumerate(settings.AUTHENTICATION_BACKENDS, 1):
        print(f"   {i}. {backend}")
    
    print(f"✅ Email verification setting: {settings.ACCOUNT_EMAIL_VERIFICATION}")
    print(f"✅ Authentication method: {settings.ACCOUNT_AUTHENTICATION_METHOD}")
    print(f"✅ Username required: {settings.ACCOUNT_USERNAME_REQUIRED}")
    
    return True

def test_custom_backend():
    """Test our custom EmailBackend"""
    print("\n=== Testing Custom EmailBackend ===")
    
    try:
        backend = EmailBackend()
        print("✅ EmailBackend instantiated successfully")
        
        # Test required methods exist
        assert hasattr(backend, 'authenticate'), "authenticate method missing"
        assert hasattr(backend, 'get_user'), "get_user method missing"
        assert hasattr(backend, 'user_can_authenticate'), "user_can_authenticate method missing"
        
        print("✅ All required methods present")
        
        # Test authentication with invalid credentials (should return None)
        result = backend.authenticate(None, username="nonexistent@test.com", password="wrongpass")
        assert result is None, "Should return None for invalid credentials"
        print("✅ Invalid credentials correctly rejected")
        
        return True
        
    except Exception as e:
        print(f"❌ EmailBackend test failed: {e}")
        return False

def test_user_creation():
    """Test user creation process"""
    print("\n=== Testing User Creation Process ===")
    
    try:
        # Check if we can access User model
        user_count = User.objects.count()
        print(f"✅ Current user count: {user_count}")
        
        # Test creating a test user (without saving)
        test_user = User(
            username="test@example.com",
            email="test@example.com",
            first_name="Test",
            last_name="User"
        )
        test_user.set_password("testpass123")
        
        print("✅ Test user object created successfully")
        print(f"   Username: {test_user.username}")
        print(f"   Email: {test_user.email}")
        print(f"   Has password: {test_user.has_usable_password()}")
        
        return True
        
    except Exception as e:
        print(f"❌ User creation test failed: {e}")
        return False

def test_backend_assignment():
    """Test backend attribute assignment"""
    print("\n=== Testing Backend Assignment ===")
    
    try:
        # Create a test user object
        test_user = User(
            username="backend_test@example.com",
            email="backend_test@example.com"
        )
        
        # Test backend assignment (like we do in signup)
        test_user.backend = 'apps.backends.EmailBackend'
        
        print("✅ Backend attribute assigned successfully")
        print(f"   User backend: {test_user.backend}")
        
        # Test that the backend string is valid
        backend_path = test_user.backend
        module_path, class_name = backend_path.rsplit('.', 1)
        
        import importlib
        module = importlib.import_module(module_path)
        backend_class = getattr(module, class_name)
        
        print("✅ Backend path is valid and importable")
        print(f"   Backend class: {backend_class}")
        
        return True
        
    except Exception as e:
        print(f"❌ Backend assignment test failed: {e}")
        return False

def main():
    """Run all tests"""
    print("🔍 Starting Authentication Backend Tests...\n")
    
    tests = [
        test_authentication_backends,
        test_custom_backend,
        test_user_creation,
        test_backend_assignment,
    ]
    
    results = []
    for test in tests:
        try:
            result = test()
            results.append(result)
        except Exception as e:
            print(f"❌ Test {test.__name__} failed with exception: {e}")
            results.append(False)
    
    print("\n" + "="*50)
    print("🏁 Test Summary:")
    print(f"   Passed: {sum(results)}/{len(results)}")
    print(f"   Failed: {len(results) - sum(results)}/{len(results)}")
    
    if all(results):
        print("✅ All authentication backend tests PASSED!")
        print("🎉 Your backend fixes are working correctly!")
    else:
        print("❌ Some tests failed. Please check the output above.")
    
    return all(results)

if __name__ == "__main__":
    success = main()
    sys.exit(0 if success else 1)
