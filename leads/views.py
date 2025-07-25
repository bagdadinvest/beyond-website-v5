from django.shortcuts import render, get_object_or_404, redirect
from django.db.models import Count
from django.http import JsonResponse
from rest_framework.views import APIView
from rest_framework.response import Response
from django.contrib.auth.decorators import login_required
from PyPDF2 import PdfReader, PdfWriter
import csv
import os
import datetime
import logging
from .models import Lead, LeadHistory, Note
from .forms import LeadForm

# Ensure no duplicate view definitions

def lead_list(request):
    print("Loading lead list...")
    leads = Lead.objects.all().order_by('-created_at')
    source_counts = (
        Lead.objects.values('source')
        .annotate(count=Count('source'))
        .order_by('-count')
    )
    source_labels = [entry['source'] for entry in source_counts]
    source_data = [entry['count'] for entry in source_counts]
    print("Lead list loaded.")

    return render(request, 'leads/lead_list.html', {
        'leads': leads,
        'source_labels': source_labels,
        'source_data': source_data
    })

def upload_csv(request):
    print("CSV upload initiated...")
    if request.method == 'POST':
        csv_file = request.FILES['file']
        if csv_file.name.endswith('.csv'):
            data = csv_file.read().decode('utf-8').splitlines()
            reader = csv.DictReader(data)
            for row in reader:
                Lead.objects.create(
                    name=row['Name'],
                    email=row['Email'],
                    phone=row.get('Phone', ''),
                    source=row['Source'],
                    message=row.get('Message', '')
                )
            print("CSV processed successfully.")
            return redirect('leads:lead_list')
    print("CSV upload failed or not a POST request.")
    return render(request, 'leads/upload_csv.html')

def edit_lead(request, pk):
    print(f"Editing lead with ID {pk}...")
    lead = get_object_or_404(Lead, pk=pk)
    if request.method == 'POST':
        form = LeadForm(request.POST, instance=lead)
        if form.is_valid():
            form.save()
            print("Lead updated successfully.")
            return redirect('leads:lead_list')
        else:
            print("Form submission invalid.")
    else:
        form = LeadForm(instance=lead)
        print("Pre-filled form loaded.")
    return render(request, 'leads/edit_lead.html', {'form': form, 'lead': lead})

def get_lead_history(request, lead_id):
    print(f"Fetching history for lead {lead_id}...")
    lead = Lead.objects.get(id=lead_id)
    history = lead.history.all().order_by('-timestamp').values('timestamp', 'action', 'user__username')
    return JsonResponse(list(history), safe=False)

def log_whatsapp_action(request, lead_id):
    print(f"Logging WhatsApp action for lead {lead_id}...")
    lead = Lead.objects.get(id=lead_id)
    LeadHistory.objects.create(
        lead=lead,
        action='WhatsApp message initiated',
        user=request.user if request.user.is_authenticated else None
    )
    return JsonResponse({'status': 'success', 'message': 'Action logged successfully'})

@login_required
def add_note(request, lead_id):
    print(f"Adding note to lead {lead_id}...")
    lead = get_object_or_404(Lead, id=lead_id)
    if request.method == 'POST':
        content = request.POST.get('content', '').strip()
        if content:
            Note.objects.create(lead=lead, user=request.user, content=content)
            print("Note added successfully.")
            return JsonResponse({'status': 'success', 'message': 'Note added successfully!'})
        else:
            print("Note content is invalid.")
    return JsonResponse({'status': 'error', 'message': 'Invalid note content!'})

def get_lead_events(request):
    print("Fetching lead events...")
    events = []
    history = LeadHistory.objects.all().order_by('timestamp')
    for entry in history:
        events.append({
            'title': f"{entry.lead.name} - {entry.action}",
            'start': entry.timestamp.strftime("%Y-%m-%dT%H:%M:%S"),
            'description': f"Action: {entry.action}, User: {entry.user or 'System'}"
        })
    print("Events fetched successfully.")
    return JsonResponse(events, safe=False)

class GenerateInvoiceView(APIView):
    def post(self, request):
        try:
            print("Incoming request data:", request.data)
            field_data = {
                "currency": request.data.get("currency", "USD"),
                "name": request.data.get("name", "N/A"),
                "contact": request.data.get("contact", "N/A"),
                "number": request.data.get("number", "N/A"),
                "date": request.data.get("date", "N/A"),
            }
            print("Field data parsed.", field_data)
            input_pdf = "/home/lotfikan/Desktop/dentidelil/invoice.pdf"
            output_pdf = f"media/invoices/invoice_{datetime.datetime.now().strftime('%Y%m%d%H%M%S')}.pdf"
            reader = PdfReader(input_pdf)
            writer = PdfWriter()
            for page in reader.pages:
                writer.add_page(page)
            writer.update_page_form_field_values(writer.pages[0], field_data)
            writer.add_metadata({"/ViewOnly": "True"})
            with open(output_pdf, "wb") as output_file:
                writer.write(output_file)
            download_link = f"https://app.dentidelil-international.com/{output_pdf}"
            print("PDF generated successfully.", download_link)
            return Response({"download_link": download_link})
        except Exception as e:
            logging.error(f"Error generating invoice: {e}")
            print("Error occurred:", str(e))
            return Response({"error": "Internal server error"}, status=500)


from django.core.mail import send_mail
from django.shortcuts import get_object_or_404, redirect
from django.contrib import messages

def send_email(request, lead_id):
    lead = get_object_or_404(Lead, id=lead_id)
    subject = "Important Update from Our Team"
    message = f"Dear {lead.name},\n\nWe wanted to reach out to you regarding your inquiry.\n\nBest regards,\nThe Team"
    from_email = "your_email@example.com"
    recipient_list = [lead.email]

    if lead.email:
        try:
            send_mail(subject, message, from_email, recipient_list)
            messages.success(request, f"Email successfully sent to {lead.name} at {lead.email}.")
        except Exception as e:
            messages.error(request, f"Failed to send email to {lead.name}: {e}")
    else:
        messages.error(request, f"Lead {lead.name} does not have a valid email address.")

    return redirect('leads:lead_list')
