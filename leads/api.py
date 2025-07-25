from django.http import FileResponse
from PyPDF2 import PdfReader, PdfWriter
import os

def fill_pdf(input_pdf, output_pdf, field_data):
    reader = PdfReader(input_pdf)
    writer = PdfWriter()

    # Copy pages and update fields
    writer.add_page(reader.pages[0])
    writer.update_page_form_field_values(writer.pages[0], field_data)

    with open(output_pdf, "wb") as output_stream:
        writer.write(output_stream)

# API View
from rest_framework.views import APIView
from rest_framework.response import Response
from .models import Lead

class GenerateTreatmentPlanView(APIView):
    def post(self, request, lead_id):
        lead = Lead.objects.get(id=lead_id)
        field_data = {
            "name": lead.name,
            "phone": lead.phone,
            "date": request.data.get("date"),
            "item1": request.data.get("item1"),
            "item1quantity": request.data.get("item1quantity"),
            "item1unitprice": request.data.get("item1unitprice"),
            "item1total": request.data.get("item1total"),
            "subtotal": request.data.get("subtotal"),
            "finaldiscount": request.data.get("finaldiscount"),
            "grandtotal": request.data.get("grandtotal"),
        }

        # Define file paths
        input_pdf = "path/to/your/template.pdf"  # Update path
        output_pdf = f"media/invoices/{lead.name.replace(' ', '_')}_invoice.pdf"

        # Fill the PDF
        fill_pdf(input_pdf, output_pdf, field_data)

        return Response({"download_link": f"/{output_pdf}"})
