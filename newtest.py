from reportlab.pdfgen import canvas
from reportlab.lib.pagesizes import letter
from PyPDF2 import PdfReader, PdfWriter, PageObject
import io

# Create overlay PDF in memory
def create_overlay(field_data):
    packet = io.BytesIO()
    c = canvas.Canvas(packet, pagesize=letter)

    # Draw form fields
    c.drawString(100, 750, f"Patient Name: {field_data['name']}")
    c.drawString(100, 730, f"Phone: {field_data['phone']}")
    c.drawString(100, 710, f"Date: {field_data['date']}")

    c.drawString(100, 690, "Item Details:")
    c.drawString(120, 670, f"{field_data['item1']} - Qty: {field_data['item1quantity']} - Unit Price: {field_data['item1unitprice']} - Total: {field_data['item1total']}")
    c.drawString(120, 650, f"{field_data['item2']} - Qty: {field_data['item2quantity']} - Unit Price: {field_data['item2unitprice']} - Total: {field_data['item2total']}")

    c.drawString(100, 630, f"Subtotal: {field_data['subtotal']}")
    c.drawString(100, 610, f"Final Discount: {field_data['finaldiscount']}")
    c.drawString(100, 590, f"Grand Total: {field_data['grandtotal']}")

    c.save()
    packet.seek(0)
    return packet

# Merge the overlay onto the original PDF
def fill_existing_pdf(template_pdf, output_pdf, field_data):
    try:
        # Create overlay with filled data
        overlay = PdfReader(create_overlay(field_data))

        # Load the original template
        reader = PdfReader(template_pdf)
        writer = PdfWriter()

        # Merge the overlay onto the original PDF
        original_page = reader.pages[0]
        overlay_page = overlay.pages[0]

        # Merge without replacing content
        original_page.merge_page(overlay_page)
        writer.add_page(original_page)

        # Save the filled PDF
        with open(output_pdf, "wb") as output_stream:
            writer.write(output_stream)

        print(f"PDF generated successfully! Saved as {output_pdf}")

    except Exception as e:
        print(f"Error: {e}")

# Correct mock data
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

# Paths to files
template_pdf = "/home/lotfikan/Desktop/dentidelil/invoice.pdf"  # Adjust the path
output_pdf = "filled_invoice_overlay_fixed.pdf"

# Generate the filled PDF
fill_existing_pdf(template_pdf, output_pdf, field_data)
