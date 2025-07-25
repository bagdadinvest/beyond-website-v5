from PyPDF2 import PdfReader

def get_pdf_fields(pdf_path):
    reader = PdfReader(pdf_path)
    fields = reader.get_form_text_fields()
    return fields

# Use the function
pdf_file = "invoice.pdf"  # Replace with the actual file path
fields = get_pdf_fields(pdf_file)

# Print out form field names
for field_name, field_value in fields.items():
    print(f"Field Name: {field_name} | Default Value: {field_value}")
