#!/usr/bin/env python
"""
Direct translation of the Italian .po file using LibreTranslate
"""
import os
import django
from django.conf import settings

# Setup Django
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'core.settings')
django.setup()

def translate_italian_po_file():
    """Translate the Italian .po file directly"""
    po_file_path = "/root/Downloads/beyond-website-main/apps/locale/it/LC_MESSAGES/django.po"
    
    print("=" * 70)
    print("🇮🇹 TRANSLATING ITALIAN .PO FILE WITH LIBRETRANSLATE")
    print("=" * 70)
    
    try:
        from polib import pofile
        from rosetta.translate_utils import translate
        
        # Load the .po file
        print(f"📂 Loading file: {po_file_path}")
        po = pofile(po_file_path)
        
        print(f"\n📊 Current file statistics:")
        print(f"   • Total entries: {len(po)}")
        print(f"   • Translated entries: {len(po.translated_entries())}")
        print(f"   • Untranslated entries: {len(po.untranslated_entries())}")
        print(f"   • Fuzzy entries: {len(po.fuzzy_entries())}")
        print(f"   • Current completion: {po.percent_translated()}%")
        
        untranslated = po.untranslated_entries()
        if not untranslated:
            print("✅ All entries are already translated!")
            return True
        
        print(f"\n🔄 Starting translation of {len(untranslated)} entries...")
        print("🌐 Using LibreTranslate: English → Italian")
        
        success_count = 0
        error_count = 0
        skipped_count = 0
        
        for i, entry in enumerate(untranslated, 1):
            if not entry.msgid or entry.obsolete:
                skipped_count += 1
                continue
                
            try:
                # Show progress
                progress = f"[{i}/{len(untranslated)}]"
                source_text = entry.msgid[:60] + "..." if len(entry.msgid) > 60 else entry.msgid
                print(f"{progress} Translating: '{source_text}'")
                
                # Translate using LibreTranslate
                translation = translate(entry.msgid, "en", "it")
                
                # Update the entry
                entry.msgstr = translation
                
                # Remove fuzzy flag if present
                if 'fuzzy' in entry.flags:
                    entry.flags.remove('fuzzy')
                
                success_count += 1
                
                # Show result
                trans_text = translation[:60] + "..." if len(translation) > 60 else translation
                print(f"     ✅ Result: '{trans_text}'")
                
                # Save progress every 10 translations
                if success_count % 10 == 0:
                    po.save()
                    print(f"     💾 Saved progress ({success_count} translations)")
                
            except Exception as e:
                error_count += 1
                print(f"     ❌ Translation failed: {e}")
                
                # Don't let too many errors stop us
                if error_count > 20:
                    print("⚠️  Too many errors, stopping translation process")
                    break
        
        # Update metadata
        po.metadata['Last-Translator'] = 'LibreTranslate + Django Rosetta <libretranslate@demo.com>'
        po.metadata['PO-Revision-Date'] = '2025-01-21 12:00+0000'
        po.metadata['X-Translated-Using'] = 'django-rosetta with LibreTranslate'
        po.metadata['Language'] = 'it'
        
        # Save the final file
        po.save()
        
        print(f"\n📈 TRANSLATION RESULTS:")
        print(f"   ✅ Successfully translated: {success_count}")
        print(f"   ❌ Translation errors: {error_count}")
        print(f"   ⏭️  Skipped (empty/obsolete): {skipped_count}")
        print(f"   📊 New completion rate: {po.percent_translated()}%")
        
        if success_count > 0:
            print(f"\n🎉 TRANSLATION COMPLETED SUCCESSFULLY!")
            print(f"💾 File saved: {po_file_path}")
            
            # Show some examples
            print(f"\n📝 Sample translations:")
            print("-" * 50)
            count = 0
            for entry in po:
                if entry.msgid and entry.msgstr and not entry.obsolete and len(entry.msgid) < 100:
                    print(f"EN: {entry.msgid}")
                    print(f"IT: {entry.msgstr}")
                    print()
                    count += 1
                    if count >= 5:
                        break
            print("-" * 50)
            
            return True
        else:
            print(f"\n❌ No translations were successful")
            return False
            
    except Exception as e:
        print(f"❌ Failed to process .po file: {e}")
        import traceback
        traceback.print_exc()
        return False

def main():
    success = translate_italian_po_file()
    
    print("\n" + "=" * 70)
    if success:
        print("🎯 ITALIAN TRANSLATION COMPLETED SUCCESSFULLY!")
        print("🚀 You can now:")
        print("   • Restart your Django server")
        print("   • Check the translations in your application")
        print("   • Use Rosetta UI to review and edit translations")
        print("   • Compile to .mo file if needed")
    else:
        print("🔧 Translation process encountered issues")
    print("=" * 70)
    
    return success

if __name__ == "__main__":
    main()
