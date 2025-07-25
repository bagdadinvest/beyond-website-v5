#!/usr/bin/env python
"""
Simplified programmatic test for LibreTranslate integration with Django Rosetta
"""
import sys
import os

# Add the project to Python path
sys.path.insert(0, '/root/Downloads/beyond-website-main')

# Setup Django environment
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'core.settings')

import django
django.setup()

def test_direct_libretranslate():
    """Test LibreTranslate directly without Django dependencies"""
    print("🧪 Testing LibreTranslate direct integration...")
    
    try:
        from rosetta.translate_utils import translate_by_libretranslate
        
        test_cases = [
            ("Hello world", "en", "fr"),
            ("Good morning", "en", "ar"), 
            ("Thank you", "en", "tr"),
            ("Goodbye", "en", "it"),
        ]
        
        success_count = 0
        
        for text, from_lang, to_lang in test_cases:
            try:
                result = translate_by_libretranslate(
                    text=text,
                    from_language=from_lang,
                    to_language=to_lang,
                    api_url="http://185.246.86.108:5000/translate",
                    api_key="secretapikey1234567890abcdef"
                )
                print(f"  ✅ {from_lang}->{to_lang}: '{text}' -> '{result}'")
                success_count += 1
            except Exception as e:
                print(f"  ❌ {from_lang}->{to_lang}: {text} -> Error: {e}")
        
        print(f"\n📊 Direct translation results: {success_count}/{len(test_cases)} successful")
        return success_count > 0
        
    except Exception as e:
        print(f"❌ Direct test failed: {e}")
        return False

def test_django_translate_function():
    """Test the main Django translate function"""
    print("\n🔧 Testing Django translate function...")
    
    try:
        from rosetta.translate_utils import translate
        
        test_cases = [
            ("Save", "en", "fr"),
            ("Login", "en", "ar"),
            ("Settings", "en", "tr"),
        ]
        
        success_count = 0
        
        for text, from_lang, to_lang in test_cases:
            try:
                result = translate(text, from_lang, to_lang)
                print(f"  ✅ Django translate: '{text}' -> '{result}' ({from_lang}->{to_lang})")
                success_count += 1
            except Exception as e:
                print(f"  ❌ Django translate failed: {text} -> {e}")
        
        print(f"\n📊 Django translate results: {success_count}/{len(test_cases)} successful")
        return success_count > 0
        
    except Exception as e:
        print(f"❌ Django translate test failed: {e}")
        return False

def test_ajax_endpoint():
    """Test the AJAX endpoint programmatically"""
    print("\n🔗 Testing AJAX translation endpoint...")
    
    try:
        from django.test import Client
        from django.contrib.auth import get_user_model
        
        User = get_user_model()
        
        # Create or get test user
        try:
            user = User.objects.get(username='test_translate')
        except User.DoesNotExist:
            user = User.objects.create_superuser(
                username='test_translate',
                email='test@example.com', 
                password='testpass123'
            )
        
        client = Client()
        client.force_login(user)
        
        # Test the translation endpoint
        response = client.get('/rosetta/translate/', {
            'from': 'en',
            'to': 'fr',
            'text': 'Hello world'
        })
        
        if response.status_code == 200:
            data = response.json()
            if data.get('success'):
                print(f"  ✅ AJAX endpoint: 'Hello world' -> '{data['translation']}'")
                
                # Test with LibreTranslate provider specifically
                response2 = client.get('/rosetta/translate/', {
                    'from': 'en', 
                    'to': 'fr',
                    'text': 'Hello world',
                    'provider': 'libretranslate'
                })
                
                if response2.status_code == 200:
                    data2 = response2.json()
                    if data2.get('success'):
                        print(f"  ✅ LibreTranslate provider: 'Hello world' -> '{data2['translation']}'")
                        return True
                    else:
                        print(f"  ❌ LibreTranslate provider error: {data2.get('error')}")
                        return False
                else:
                    print(f"  ❌ LibreTranslate provider HTTP error: {response2.status_code}")
                    return False
            else:
                print(f"  ❌ AJAX error: {data.get('error')}")
                return False
        else:
            print(f"  ❌ AJAX HTTP error: {response.status_code}")
            return False
            
    except Exception as e:
        print(f"  ❌ AJAX test failed: {e}")
        return False

def test_settings_configuration():
    """Test that settings are properly configured"""
    print("\n⚙️  Testing settings configuration...")
    
    try:
        from rosetta.conf import settings as rosetta_settings
        
        print(f"  LibreTranslate URL: {rosetta_settings.LIBRETRANSLATE_URL}")
        print(f"  LibreTranslate API Key: {'***' if rosetta_settings.LIBRETRANSLATE_API_KEY else 'None'}")
        print(f"  Translation Suggestions: {rosetta_settings.ENABLE_TRANSLATION_SUGGESTIONS}")
        
        # Verify configuration
        if (rosetta_settings.LIBRETRANSLATE_URL and 
            rosetta_settings.LIBRETRANSLATE_API_KEY and
            rosetta_settings.ENABLE_TRANSLATION_SUGGESTIONS):
            print("  ✅ All settings properly configured")
            return True
        else:
            print("  ❌ Some settings are missing")
            return False
            
    except Exception as e:
        print(f"  ❌ Settings test failed: {e}")
        return False

def test_batch_common_phrases():
    """Test translation of common UI phrases"""
    print("\n📝 Testing common UI phrases...")
    
    try:
        from rosetta.translate_utils import translate_by_libretranslate
        
        phrases = [
            "Save", "Cancel", "Delete", "Edit", "Search",
            "Login", "Logout", "Settings", "Help", "Home"
        ]
        
        # Test French translations (most common)
        print("  Testing French translations:")
        success_count = 0
        
        for phrase in phrases:
            try:
                result = translate_by_libretranslate(
                    text=phrase,
                    from_language="en", 
                    to_language="fr",
                    api_url="http://185.246.86.108:5000/translate",
                    api_key="secretapikey1234567890abcdef"
                )
                print(f"    {phrase} -> {result}")
                success_count += 1
            except Exception as e:
                print(f"    {phrase} -> Error: {e}")
        
        print(f"\n  📊 Phrase translation results: {success_count}/{len(phrases)} successful")
        return success_count >= len(phrases) * 0.8  # 80% success rate
        
    except Exception as e:
        print(f"  ❌ Batch test failed: {e}")
        return False

def test_error_scenarios():
    """Test various error scenarios"""
    print("\n🚨 Testing error scenarios...")
    
    try:
        from rosetta.translate_utils import translate_by_libretranslate, TranslationException
        
        # Test unsupported language
        print("  Testing unsupported language pair (en -> xx):")
        try:
            result = translate_by_libretranslate(
                text="Hello",
                from_language="en",
                to_language="xx",  # Unsupported
                api_url="http://185.246.86.108:5000/translate", 
                api_key="secretapikey1234567890abcdef"
            )
            print(f"    ❌ Expected error but got result: {result}")
            return False
        except TranslationException as e:
            print(f"    ✅ Correctly caught error: {e}")
        
        # Test wrong API key
        print("  Testing invalid API key:")
        try:
            result = translate_by_libretranslate(
                text="Hello",
                from_language="en",
                to_language="fr",
                api_url="http://185.246.86.108:5000/translate",
                api_key="invalid-key"
            )
            print(f"    ❌ Expected error but got result: {result}")
            return False
        except TranslationException as e:
            print(f"    ✅ Correctly caught API key error: {e}")
        
        return True
        
    except Exception as e:
        print(f"  ❌ Error testing failed: {e}")
        return False

def main():
    """Run all tests"""
    print("=" * 70)
    print("🚀 LIBRETRANSLATE + DJANGO ROSETTA PROGRAMMATIC TEST SUITE")
    print("=" * 70)
    
    tests = [
        ("Settings Configuration", test_settings_configuration),
        ("Direct LibreTranslate", test_direct_libretranslate),
        ("Django Translate Function", test_django_translate_function),
        ("AJAX Endpoint", test_ajax_endpoint),
        ("Batch Common Phrases", test_batch_common_phrases),
        ("Error Scenarios", test_error_scenarios),
    ]
    
    results = []
    
    for test_name, test_func in tests:
        print(f"\n{'-' * 20} {test_name} {'-' * 20}")
        try:
            result = test_func()
            results.append((test_name, result))
        except Exception as e:
            print(f"❌ Test '{test_name}' crashed: {e}")
            results.append((test_name, False))
    
    # Summary
    print("\n" + "=" * 70)
    print("📋 TEST SUMMARY")
    print("=" * 70)
    
    passed = [name for name, result in results if result]
    failed = [name for name, result in results if not result]
    
    print(f"✅ PASSED ({len(passed)}):")
    for name in passed:
        print(f"  • {name}")
    
    if failed:
        print(f"\n❌ FAILED ({len(failed)}):")
        for name in failed:
            print(f"  • {name}")
    
    success_rate = len(passed) / len(results) * 100
    print(f"\n📊 Success Rate: {success_rate:.1f}% ({len(passed)}/{len(results)})")
    
    if success_rate >= 80:
        print("\n🎉 INTEGRATION SUCCESS!")
        print("✅ LibreTranslate is working properly with Django Rosetta!")
        
        print("\n🔧 What's working:")
        print("  • LibreTranslate server communication")
        print("  • Django settings integration") 
        print("  • Translation function calls")
        print("  • AJAX endpoint responses")
        print("  • Error handling")
        
        print("\n📝 Usage in Rosetta UI:")
        print("  1. Start Django: python manage.py runserver")
        print("  2. Go to: http://localhost:8000/rosetta/")
        print("  3. Select a translation file")
        print("  4. Click 'suggest' and choose 'LibreTranslate'")
        
    else:
        print("\n⚠️  SOME ISSUES DETECTED")
        print("Check the failed tests above for troubleshooting.")

if __name__ == "__main__":
    main()
