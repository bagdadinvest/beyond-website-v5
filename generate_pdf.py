from PyPDF2 import PdfReader, PdfWriter

# Inspect the fields in the PDF
def inspect_pdf_fields(input_pdf):
    reader = PdfReader(input_pdf)
    fields = reader.get_form_text_fields()
    print("Detected Fields:")
    for field, value in fields.items():
        print(f"Field: {field} | Default Value: {value}")
    return fields


# Fill form fields and save the PDF
def fill_pdf(input_pdf, output_pdf, field_data):
    try:
        reader = PdfReader(input_pdf)
        writer = PdfWriter()

        # Copy the first page
        page = reader.pages[0]
        writer.add_page(page)

        # Update form fields
        print("Filling Form Fields...")
        writer.update_page_form_field_values(page, field_data)

        # Save the filled PDF
        with open(output_pdf, "wb") as output_stream:
            writer.write(output_stream)

        print(f"PDF generated successfully! Saved as {output_pdf}")
    except Exception as e:
        print(f"Error: {e}")


# Correct mock data based on inspected fields
field_data = {
    "name": "John Doe",
    "phone": "1234567890",
    "date": "2024-12-08",
    "item1": "Zirconium Crowns",
    "item1quantity": "27",
    "item1unitprice": "111.11",
    "item1total": "3000",
    "item2": "VIP Transfer",
    "item2quantity": "1",
    "item2unitprice": "0",
    "item2total": "0",
    "subtotal": "3000",
    "finaldiscount": "0",
    "grandtotal": "3000"
}

# File paths
input_pdf = "/home/lotfikan/Desktop/dentidelil/invoice.pdf"
output_pdf = "filled_invoice_debug.pdf"

# Inspect and fill the PDF
inspected_fields = inspect_pdf_fields(input_pdf)
fill_pdf(input_pdf, output_pdf, field_data)
