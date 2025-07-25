from reportlab.pdfgen import canvas
from reportlab.lib.pagesizes import letter

# Define the PDF generation function
def generate_invoice(output_pdf, field_data):
    try:
        # Create a canvas for the new PDF
        c = canvas.Canvas(output_pdf, pagesize=letter)
        
        # Add the invoice header
        c.drawString(100, 750, f"Patient Name: {field_data['name']}")
        c.drawString(100, 730, f"Phone: {field_data['phone']}")
        c.drawString(100, 710, f"Date: {field_data['date']}")

        # Add item details
        c.drawString(100, 690, "Item Details:")
        c.drawString(120, 670, f"{field_data['item1']} - Qty: {field_data['item1quantity']} - Unit Price: {field_data['item1unitprice']} - Total: {field_data['item1total']}")

        # Add second item if present
        c.drawString(120, 650, f"{field_data['item2']} - Qty: {field_data['item2quantity']} - Unit Price: {field_data['item2unitprice']} - Total: {field_data['item2total']}")

        # Summary section
        c.drawString(100, 630, f"Subtotal: {field_data['subtotal']}")
        c.drawString(100, 610, f"Final Discount: {field_data['finaldiscount']}")
        c.drawString(100, 590, f"Grand Total: {field_data['grandtotal']}")

        # Save and close the PDF
        c.save()
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

# Output PDF file
output_pdf = "generated_invoice_reportlab.pdf"

# Generate the filled PDF
generate_invoice(output_pdf, field_data)
