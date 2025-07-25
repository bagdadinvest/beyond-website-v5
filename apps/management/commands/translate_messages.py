import os
import requests
import logging
from django.core.management.base import BaseCommand
import subprocess

# Set up logging
logging.basicConfig(level=logging.DEBUG)
logger = logging.getLogger(__name__)

class Command(BaseCommand):
    help = 'Translate untranslated text segments in .po files using a free API and compile messages for a specified language'

    def handle(self, *args, **kwargs):
        # Ask for language code input from the user
        language_code = input("Please enter the language code (e.g., 'fr' for French): ").strip()
        
        if not language_code:
            logger.error("No language code provided. Exiting.")
            return
        
        # Step 1: Check locale directory for the language file
        logger.debug(f"Checking locale directory for language: {language_code}")
        po_file_path = os.path.join('locale', language_code, 'LC_MESSAGES', 'django.po')
        
        if not os.path.exists(po_file_path):
            logger.error(f"No .po file found at {po_file_path}")
            return
        
        # Step 2: Extract untranslated text segments
        logger.debug("Extracting untranslated text segments from the .po file.")
        untranslated_segments = self.extract_untranslated_segments(po_file_path)
        
        if not untranslated_segments:
            logger.debug("No untranslated segments found.")
            return

        logger.debug(f"Untranslated segments: {untranslated_segments}")

        # Step 3: Translate untranslated segments
        translated_segments = {}
        for segment in untranslated_segments:
            translated_text = self.translate_text(segment, language_code)
            if translated_text:
                translated_segments[segment] = translated_text
                logger.debug(f"Translated '{segment}' to '{translated_text}'.")

        # Step 4: Insert translated texts where needed
        logger.debug("Inserting translated texts into the .po file.")
        self.insert_translations(po_file_path, translated_segments)

        # Step 5: Compile messages
        logger.debug("Compiling translated messages.")
        try:
            result = subprocess.run(
                ['django-admin', 'compilemessages'],
                check=False,  # Avoid stopping the script
                stdout=subprocess.PIPE,
                stderr=subprocess.PIPE
            )
            if result.returncode != 0:
                logger.error(f"Error during compilemessages: {result.stderr.decode('utf-8')}")
                return
            logger.debug("Successfully compiled messages.")
        except Exception as e:
            logger.error(f"Unexpected error during compilemessages: {e}")

        self.stdout.write(self.style.SUCCESS('Translation and compilation process complete.'))

    def extract_untranslated_segments(self, po_file_path):
        untranslated_segments = []
        
        try:
            with open(po_file_path, 'r', encoding='utf-8') as po_file:
                lines = po_file.readlines()
                for i in range(len(lines)):
                    if lines[i].startswith('msgid') and (i + 1 < len(lines) and lines[i + 1].startswith('msgstr ""')):
                        segment = lines[i].split('msgid')[1].strip().strip('"')
                        untranslated_segments.append(segment)
        except FileNotFoundError as e:
            logger.error(f"PO file not found: {e}")
        except Exception as e:
            logger.error(f"Error while reading PO file: {e}")
        
        return untranslated_segments

    def translate_text(self, text, language_code):
        logger.debug(f"Translating text: {text}")
        try:
            response = requests.get(
                'https://api.mymemory.translated.net/get',
                params={'q': text, 'langpair': f'en|{language_code}'}  # English to the specified language
            )
            response.raise_for_status()  # This will raise an HTTPError if the HTTP request returned an unsuccessful status code
            return response.json().get('responseData', {}).get('translatedText')
        except requests.exceptions.RequestException as e:
            logger.error(f"Error while translating text '{text}': {e}")
            raise SystemExit(f"Stopping process due to API error: {e}")  # Stop the process

    def insert_translations(self, po_file_path, translated_segments):
        try:
            with open(po_file_path, 'r', encoding='utf-8') as po_file:
                lines = po_file.readlines()
            
            new_lines = []
            for i in range(len(lines)):
                new_lines.append(lines[i])
                if lines[i].startswith('msgid') and (i + 1 < len(lines) and lines[i + 1].startswith('msgstr ""')):
                    segment = lines[i].split('msgid')[1].strip().strip('"')
                    if segment in translated_segments:
                        new_lines.append(f'msgstr "{translated_segments[segment]}"\n')
                        i += 1
                    else:
                        new_lines.append(lines[i + 1])
                        i += 1
            
            with open(po_file_path, 'w', encoding='utf-8') as po_file:
                po_file.writelines(new_lines)
            
            logger.debug("Successfully inserted translations into PO file.")
        except FileNotFoundError as e:
            logger.error(f"PO file not found: {e}")
        except Exception as e:
            logger.error(f"Error while writing PO file: {e}")
