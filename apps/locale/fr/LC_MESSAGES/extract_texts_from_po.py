import os
import csv
import polib

def update_po_file(po_file, translations):
    po = polib.pofile(po_file)
    for entry in po:
        if entry.msgid in translations:
            entry.msgstr = translations[entry.msgid]
    po.save()

def load_translations_from_csv(csv_file):
    translations = {}
    with open(csv_file, 'r', encoding='utf-8') as csvfile:
        reader = csv.reader(csvfile)
        for row in reader:
            if len(row) == 2:
                msgid, msgstr = row
                translations[msgid] = msgstr
    return translations

def update_po_files(directory, translations):
    po_files_found = False
    for root, _, files in os.walk(directory):
        for file in files:
            if file.endswith('.po'):
                po_files_found = True
                filepath = os.path.join(root, file)
                print(f"Updating .po file: {filepath}")
                update_po_file(filepath, translations)
    if not po_files_found:
        print("No .po files found.")

if __name__ == "__main__":
    # Current directory where the script is located
    current_dir = os.path.dirname(os.path.abspath(__file__))
    csv_file = os.path.join(current_dir, 'translated_texts')  # CSV file with translations
    translations = load_translations_from_csv(csv_file)
    update_po_files(current_dir, translations)
    print(f"PO files updated with translations from {csv_file}")
