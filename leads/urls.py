from django.urls import path
from . import views
from .api import GenerateTreatmentPlanView
from .views import GenerateInvoiceView

app_name = 'leads'  # Correctly set the namespace

urlpatterns = [
    path('', views.lead_list, name='lead_list'),
    path('edit-lead/<int:pk>/', views.edit_lead, name='edit_lead'),
    path('log-whatsapp-action/<int:lead_id>/', views.log_whatsapp_action, name='log_whatsapp_action'),
    path('lead-history/<int:lead_id>/', views.get_lead_history, name='lead_history'),
    path('add-note/<int:lead_id>/', views.add_note, name='add_note'),
    path('upload-csv/', views.upload_csv, name='upload_csv'),
    path('calendar-events/', views.get_lead_events, name='calendar_events'),
    path('api/generate-invoice/', GenerateInvoiceView.as_view(), name='generate-invoice'),
    path('send-email/<int:lead_id>/', views.send_email, name='send_email'),  # New URL

]
