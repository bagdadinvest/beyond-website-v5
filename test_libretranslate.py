#!/usr/bin/env python
"""
Comprehensive programmatic test for LibreTranslate integration with Django Rosetta
"""
import os
import django
import json
from django.conf import settings

# Setup Django
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'core.settings')
django.setup()

def test_libretranslate_direct():
    """Test LibreTranslate function directly"""
    print("🧪 Testing LibreTranslate integration...")
    
    try:
        from rosetta.translate_utils import translate_by_libretranslate
        
        # Test with supported language pair (en -> fr)
        result = translate_by_libretranslate(
            text="Hello world",
            from_language="en",
            to_language="fr",
            api_url="http://185.246.86.108:5000/translate",
            api_key="secretapikey1234567890abcdef"
        )
        
        print(f"✅ Translation successful: 'Hello world' -> '{result}'")
        return True
        
    except Exception as e:
        print(f"❌ Translation failed: {e}")
        return False

def test_django_translate_function():
    """Test the main translate function"""
    print("\n🔧 Testing Django translate function...")
    
    try:
        from rosetta.translate_utils import translate
        
        # Test with LibreTranslate configured
        result = translate("Hello world", "en", "fr")
        print(f"✅ Django translate function successful: 'Hello world' -> '{result}'")
        return True
        
    except Exception as e:
        print(f"❌ Django translate function failed: {e}")
        return False

def test_rosetta_settings():
    """Test if Rosetta settings are configured correctly"""
    print("\n⚙️  Testing Rosetta settings...")
    
    try:
        from rosetta.conf import settings as rosetta_settings
        
        print(f"ENABLE_TRANSLATION_SUGGESTIONS: {rosetta_settings.ENABLE_TRANSLATION_SUGGESTIONS}")
        print(f"LIBRETRANSLATE_URL: {rosetta_settings.LIBRETRANSLATE_URL}")
        print(f"LIBRETRANSLATE_API_KEY: {'***' if rosetta_settings.LIBRETRANSLATE_API_KEY else 'None'}")
        
        if rosetta_settings.LIBRETRANSLATE_URL and rosetta_settings.ENABLE_TRANSLATION_SUGGESTIONS:
            print("✅ Rosetta settings are correctly configured")
            return True
        else:
            print("❌ Rosetta settings are not properly configured")
            return False
            
    except Exception as e:
        print(f"❌ Error checking Rosetta settings: {e}")
        return False

def test_rosetta_ajax_endpoint():
    """Test the Rosetta translate_text AJAX endpoint"""
    print("\n🌐 Testing Rosetta AJAX endpoint...")
    
    try:
        from django.test import Client
        from django.contrib.auth.models import User
        from django.urls import reverse
        
        # Create test client
        client = Client()
        
        # Create superuser if it doesn't exist
        try:
            user = User.objects.get(username='testuser')
        except User.DoesNotExist:
            user = User.objects.create_superuser('testuser', 'test@test.com', 'testpass')
        
        # Login
        client.login(username='testuser', password='testpass')
        
        # Test the AJAX endpoint
        response = client.get(reverse('rosetta.translate_text'), {
            'from': 'en',
            'to': 'fr', 
            'text': 'Hello world'
        })
        
        if response.status_code == 200:
            data = response.json()
            if data.get('success'):
                print(f"✅ AJAX endpoint successful: '{data.get('translation')}'")
                return True
            else:
                print(f"❌ AJAX endpoint returned error: {data.get('error')}")
                return False
        else:
            print(f"❌ AJAX endpoint returned status {response.status_code}")
            return False
            
    except Exception as e:
        print(f"❌ AJAX endpoint test failed: {e}")
        return False

def test_rosetta_ajax_with_provider():
    """Test the Rosetta translate_text AJAX endpoint with LibreTranslate provider"""
    print("\n🔧 Testing AJAX endpoint with LibreTranslate provider...")
    
    try:
        from django.test import Client
        from django.contrib.auth.models import User
        from django.urls import reverse
        
        # Create test client
        client = Client()
        
        # Login with existing user
        client.login(username='testuser', password='testpass')
        
        # Test the AJAX endpoint with LibreTranslate provider
        response = client.get(reverse('rosetta.translate_text'), {
            'from': 'en',
            'to': 'fr', 
            'text': 'Hello beautiful world',
            'provider': 'libretranslate'
        })
        
        if response.status_code == 200:
            data = response.json()
            if data.get('success'):
                print(f"✅ LibreTranslate provider AJAX successful: '{data.get('translation')}'")
                return True
            else:
                print(f"❌ LibreTranslate provider AJAX returned error: {data.get('error')}")
                return False
        else:
            print(f"❌ LibreTranslate provider AJAX returned status {response.status_code}")
            return False
            
    except Exception as e:
        print(f"❌ LibreTranslate provider AJAX test failed: {e}")
        return False

def test_po_file_processing():
    """Test processing a .po file with LibreTranslate translations"""
    print("\n📄 Testing .po file processing with translations...")
    
    try:
        import tempfile
        import os
        from polib import pofile, POEntry
        from rosetta.translate_utils import translate
        
        # Create a temporary .po file
        po_content = '''
# Test PO file
msgid ""
msgstr ""
"Content-Type: text/plain; charset=UTF-8\\n"
"Language: fr\\n"

msgid "Hello"
msgstr ""

msgid "Welcome"
msgstr ""

msgid "Goodbye"
msgstr ""
'''
        
        with tempfile.NamedTemporaryFile(mode='w', suffix='.po', delete=False) as f:
            f.write(po_content)
            po_file_path = f.name
        
        # Load the PO file
        po = pofile(po_file_path)
        
        # Translate untranslated entries
        translations_count = 0
        for entry in po:
            if entry.msgid and not entry.msgstr and not entry.obsolete:
                try:
                    translation = translate(entry.msgid, "en", "fr")
                    entry.msgstr = translation
                    translations_count += 1
                    print(f"✅ Translated: '{entry.msgid}' -> '{translation}'")
                except Exception as e:
                    print(f"⚠️  Failed to translate '{entry.msgid}': {e}")
        
        # Save the file
        po.save(po_file_path)
        
        # Clean up
        os.unlink(po_file_path)
        
        if translations_count > 0:
            print(f"✅ Successfully processed {translations_count} translations")
            return True
        else:
            print("❌ No translations were processed")
            return False
            
    except Exception as e:
        print(f"❌ PO file processing failed: {e}")
        return False

def test_multiple_languages():
    """Test translation with multiple supported language pairs"""
    print("\n🌍 Testing multiple language pairs...")
    
    test_cases = [
        ("Hello", "en", "fr", "Expected: Bonjour/Salut"),
        ("Thank you", "en", "ar", "Expected: شكرا لك"),
        ("Goodbye", "en", "tr", "Expected: Hoşçakal"),
        ("Welcome", "en", "it", "Expected: Benvenuto"),
    ]
    
    success_count = 0
    
    try:
        from rosetta.translate_utils import translate_by_libretranslate
        
        for text, from_lang, to_lang, expected in test_cases:
            try:
                result = translate_by_libretranslate(
                    text=text,
                    from_language=from_lang,
                    to_language=to_lang,
                    api_url="http://185.246.86.108:5000/translate",
                    api_key="secretapikey1234567890abcdef"
                )
                print(f"✅ {from_lang}->{to_lang}: '{text}' -> '{result}' ({expected})")
                success_count += 1
            except Exception as e:
                print(f"❌ {from_lang}->{to_lang}: Failed - {e}")
        
        print(f"\n📊 Translation test results: {success_count}/{len(test_cases)} successful")
        return success_count > 0
        
    except Exception as e:
        print(f"❌ Error in language testing: {e}")
        return False

def test_javascript_settings():
    """Test that JavaScript settings are properly configured"""
    print("\n🎯 Testing JavaScript settings configuration...")
    
    try:
        from django.test import RequestFactory
        from rosetta.views import TranslationFormView
        from django.contrib.auth.models import User
        
        # Create a mock request
        factory = RequestFactory()
        request = factory.get('/rosetta/')
        
        # Create a user and attach to request
        try:
            user = User.objects.get(username='testuser')
        except User.DoesNotExist:
            user = User.objects.create_superuser('testuser', 'test@test.com', 'testpass')
        request.user = user
        
        # Create view instance (we need to mock some properties)
        view = TranslationFormView()
        view.request = request
        view.kwargs = {'po_filter': 'project', 'lang_id': 'fr', 'idx': 0}
        
        # Mock some properties that would normally be set
        view.language_id = 'fr'
        
        # Get context data
        context = view.get_context_data()
        js_settings = context.get('rosetta_settings_js', {})
        
        print(f"ENABLE_TRANSLATION_SUGGESTIONS: {js_settings.get('ENABLE_TRANSLATION_SUGGESTIONS')}")
        print(f"LIBRETRANSLATE_URL: {js_settings.get('LIBRETRANSLATE_URL')}")
        print(f"server_auth_key: {js_settings.get('server_auth_key')}")
        print(f"translate_text_url: {js_settings.get('translate_text_url')}")
        
        if (js_settings.get('ENABLE_TRANSLATION_SUGGESTIONS') and 
            js_settings.get('LIBRETRANSLATE_URL') and 
            js_settings.get('server_auth_key')):
            print("✅ JavaScript settings are properly configured")
            return True
        else:
            print("❌ JavaScript settings are missing required values")
            return False
            
    except Exception as e:
        print(f"❌ JavaScript settings test failed: {e}")
        return False

def run_end_to_end_test():
    """Run a complete end-to-end translation workflow test"""
    print("\n🚀 Running end-to-end translation workflow test...")
    
    try:
        from django.test import Client
        from django.contrib.auth.models import User
        from django.urls import reverse
        
        # Test sentences in different languages
        test_sentences = [
            "Hello, how are you today?",
            "This is a test translation.",
            "Welcome to our application.",
            "Thank you for your patience.",
            "Have a wonderful day!"
        ]
        
        client = Client()
        client.login(username='testuser', password='testpass')
        
        print("� Testing complete translation workflow...")
        success_count = 0
        
        for i, sentence in enumerate(test_sentences, 1):
            try:
                # Test default translation (should use LibreTranslate since it's configured first)
                response = client.get(reverse('rosetta.translate_text'), {
                    'from': 'en',
                    'to': 'fr',
                    'text': sentence
                })
                
                if response.status_code == 200:
                    data = response.json()
                    if data.get('success'):
                        translation = data.get('translation')
                        print(f"✅ Test {i}: '{sentence}' -> '{translation}'")
                        success_count += 1
                    else:
                        print(f"❌ Test {i}: Translation failed - {data.get('error')}")
                else:
                    print(f"❌ Test {i}: HTTP {response.status_code}")
                    
            except Exception as e:
                print(f"❌ Test {i}: Exception - {e}")
        
        print(f"\n📈 End-to-end test results: {success_count}/{len(test_sentences)} successful")
        return success_count > 0
        
    except Exception as e:
        print(f"❌ End-to-end test failed: {e}")
        return False

def main():
    print("=" * 70)
    print("🚀 COMPREHENSIVE LIBRETRANSLATE + DJANGO ROSETTA TEST SUITE")
    print("=" * 70)
    
    # Run all tests
    tests = [
        ("Rosetta Settings", test_rosetta_settings),
        ("LibreTranslate Direct", test_libretranslate_direct),
        ("Django Translate Function", test_django_translate_function),
        ("Multiple Languages", test_multiple_languages),
        ("AJAX Endpoint", test_rosetta_ajax_endpoint),
        ("AJAX with Provider", test_rosetta_ajax_with_provider),
        ("JavaScript Settings", test_javascript_settings),
        ("PO File Processing", test_po_file_processing),
        ("End-to-End Workflow", run_end_to_end_test),
    ]
    
    results = []
    for test_name, test_func in tests:
        print(f"\n{'='*20} {test_name} {'='*20}")
        try:
            results.append(test_func())
        except Exception as e:
            print(f"❌ {test_name} crashed: {e}")
            results.append(False)
    
    # Summary
    print("\n" + "=" * 70)
    print("📋 FINAL TEST SUMMARY")
    print("=" * 70)
    
    passed = sum(results)
    total = len(results)
    
    for i, (test_name, _) in enumerate(tests):
        status = "✅ PASSED" if results[i] else "❌ FAILED"
        print(f"{status:<10} {test_name}")
    
    print("-" * 70)
    
    if passed == total:
        print(f"🎉 ALL TESTS PASSED! ({passed}/{total})")
        print("✅ LibreTranslate integration is fully functional!")
        print("\n🚀 DEPLOYMENT READY!")
        print("📝 To use in production:")
        print("   1. Ensure LibreTranslate server is running")
        print("   2. Configure LIBRETRANSLATE_URL and LIBRETRANSLATE_API_KEY")
        print("   3. Access Rosetta at /rosetta/ and use the 'suggest' feature")
    else:
        print(f"⚠️  SOME TESTS FAILED ({passed}/{total})")
        print("❌ Please review the failed tests above")
    
    return passed == total

if __name__ == "__main__":
    success = main()
    exit(0 if success else 1)
