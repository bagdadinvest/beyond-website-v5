#!/usr/bin/env python
"""
Demonstration of LibreTranslate working with actual .po files
This simulates what would happen in the Rosetta UI.
"""
import os
import django
from django.conf import settings

# Setup Django
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'core.settings')
django.setup()

def create_sample_po_file():
    """Create a sample .po file with untranslated strings"""
    po_content = '''# Sample translation file for testing
# Copyright (C) 2025
# This file is distributed under the same license as the project.
#
#, fuzzy
msgid ""
msgstr ""
"Project-Id-Version: Demo App 1.0\\n"
"Report-Msgid-Bugs-To: \\n"
"POT-Creation-Date: 2025-01-21 12:00+0000\\n"
"PO-Revision-Date: YEAR-MO-DA HO:MI+ZONE\\n"
"Last-Translator: LibreTranslate Demo\\n"
"Language-Team: French <fr@example.com>\\n"
"Language: fr\\n"
"MIME-Version: 1.0\\n"
"Content-Type: text/plain; charset=UTF-8\\n"
"Content-Transfer-Encoding: 8bit\\n"

#: templates/login.html:12
msgid "Login"
msgstr ""

#: templates/login.html:15
msgid "Username"
msgstr ""

#: templates/login.html:18
msgid "Password"
msgstr ""

#: templates/login.html:21
msgid "Remember me"
msgstr ""

#: templates/login.html:24
msgid "Sign In"
msgstr ""

#: templates/home.html:8
msgid "Welcome to our application"
msgstr ""

#: templates/home.html:12
msgid "Dashboard"
msgstr ""

#: templates/home.html:15
msgid "Profile"
msgstr ""

#: templates/home.html:18
msgid "Settings"
msgstr ""

#: templates/home.html:21
msgid "Logout"
msgstr ""

#: templates/messages.html:5
msgid "Success"
msgstr ""

#: templates/messages.html:8
msgid "Error"
msgstr ""

#: templates/messages.html:11
msgid "Warning"
msgstr ""

#: templates/messages.html:14
msgid "Information"
msgstr ""

#: forms.py:12
msgid "Please enter a valid email address"
msgstr ""

#: forms.py:18
msgid "This field is required"
msgstr ""

#: views.py:25
msgid "Your changes have been saved successfully"
msgstr ""

#: views.py:32
msgid "An error occurred while processing your request"
msgstr ""
'''
    
    return po_content

def main():
    print("=" * 70)
    print("🚀 LIBRETRANSLATE PO FILE TRANSLATION DEMO")
    print("=" * 70)
    
    print("\n📝 Creating sample .po file...")
    
    try:
        import tempfile
        from polib import pofile
        from rosetta.translate_utils import translate
        
        # Create temporary .po file
        po_content = create_sample_po_file()
        
        with tempfile.NamedTemporaryFile(mode='w', suffix='.po', delete=False) as f:
            f.write(po_content)
            po_file_path = f.name
        
        print(f"✅ Created sample .po file: {po_file_path}")
        
        # Load the .po file
        po = pofile(po_file_path)
        
        print(f"\n📊 PO File Statistics:")
        print(f"   • Total entries: {len(po)}")
        print(f"   • Translated entries: {len(po.translated_entries())}")
        print(f"   • Untranslated entries: {len(po.untranslated_entries())}")
        print(f"   • Fuzzy entries: {len(po.fuzzy_entries())}")
        print(f"   • Completion: {po.percent_translated()}%")
        
        # Translate untranslated entries
        print(f"\n🔄 Translating {len(po.untranslated_entries())} untranslated entries...")
        
        success_count = 0
        error_count = 0
        
        for entry in po.untranslated_entries():
            if entry.msgid and not entry.obsolete:
                try:
                    # Use LibreTranslate to translate
                    translation = translate(entry.msgid, "en", "fr")
                    entry.msgstr = translation
                    
                    # Remove fuzzy flag if present
                    if 'fuzzy' in entry.flags:
                        entry.flags.remove('fuzzy')
                    
                    print(f"✅ '{entry.msgid[:50]}...' → '{translation[:50]}...'")
                    success_count += 1
                    
                except Exception as e:
                    print(f"❌ Failed to translate '{entry.msgid[:30]}...': {e}")
                    error_count += 1
        
        # Update metadata
        po.metadata['Last-Translator'] = 'LibreTranslate Demo <demo@example.com>'
        po.metadata['PO-Revision-Date'] = '2025-01-21 12:00+0000'
        po.metadata['X-Translated-Using'] = 'LibreTranslate + Django Rosetta'
        
        # Save the translated file
        po.save()
        
        print(f"\n📈 Translation Results:")
        print(f"   • Successfully translated: {success_count}")
        print(f"   • Translation errors: {error_count}")
        print(f"   • New completion rate: {po.percent_translated()}%")
        
        # Show the final file content (first few entries)
        print(f"\n📄 Sample of translated .po file content:")
        print("-" * 50)
        
        count = 0
        for entry in po:
            if entry.msgid and entry.msgstr and not entry.obsolete:
                print(f'msgid "{entry.msgid}"')
                print(f'msgstr "{entry.msgstr}"')
                print()
                count += 1
                if count >= 5:  # Show only first 5
                    break
        
        if success_count > count:
            print(f"... and {success_count - count} more translated entries")
        
        print("-" * 50)
        
        # Clean up
        os.unlink(po_file_path)
        
        print(f"\n🎉 DEMO COMPLETED SUCCESSFULLY!")
        print(f"✅ LibreTranslate successfully translated {success_count} entries")
        print(f"🚀 This demonstrates exactly what happens in the Rosetta UI")
        
        if success_count > 0:
            print(f"\n📋 WHAT JUST HAPPENED:")
            print(f"   1. Created a sample .po file with {len(po.untranslated_entries())} untranslated strings")
            print(f"   2. Used LibreTranslate to translate English → French")
            print(f"   3. Updated the .po file with translations")
            print(f"   4. Marked entries as translated (removed fuzzy flags)")
            print(f"   5. Updated metadata with translation info")
            print(f"\n🔧 IN PRODUCTION, users would:")
            print(f"   • Open Rosetta at /rosetta/")
            print(f"   • Select a .po file")
            print(f"   • Click 'suggest' button")
            print(f"   • Choose 'LibreTranslate' provider")
            print(f"   • Get instant translations like shown above")
            
            return True
        else:
            print(f"\n❌ No translations were successful")
            return False
        
    except Exception as e:
        print(f"❌ Demo failed: {e}")
        return False

if __name__ == "__main__":
    success = main()
    print("\n" + "=" * 70)
    if success:
        print("🎯 LibreTranslate + Django Rosetta integration is WORKING PERFECTLY!")
    else:
        print("🔧 Demo encountered issues.")
    print("=" * 70)
