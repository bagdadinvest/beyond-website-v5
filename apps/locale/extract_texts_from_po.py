import os
import csv
import polib

def extract_texts_from_po(po_file):
    po = polib.pofile(po_file)
    texts = [entry.msgid for entry in po]
    return texts

def extract_from_po_files(directory):
    all_texts = []
    for root, _, files in os.walk(directory):
        for file in files:
            if file.endswith('.po'):
                filepath = os.path.join(root, file)
                texts = extract_texts_from_po(filepath)
                all_texts.extend(texts)
    return all_texts

def save_to_csv(texts, output_file):
    with open(output_file, 'w', newline='', encoding='utf-8') as csvfile:
        writer = csv.writer(csvfile)
        for text in texts:
            writer.writerow([text])

if __name__ == "__main__":
    # Current directory where the script is located
    current_dir = os.path.dirname(os.path.abspath(__file__))
    output_file = os.path.join(current_dir, 'extracted_texts.csv')
    texts = extract_from_po_files(current_dir)
    save_to_csv(texts, output_file)
