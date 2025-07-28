from django.urls import path, include  # Ensure 'include' is imported
from apps import views, TreatmentPlanview, mew, errors
from django.conf.urls.static import static
from django.conf import settings
from .dataviz import comprehensive_dashboard
from . import invoice_ninja_views  # Import Invoice Ninja views
from flights import views as flight_views
app_name = 'app'

urlpatterns = [
    path('', views.login_view, name='login'),
    path('login/', views.login_view, name='login'),
    path('logout/', views.logout_view, name='logout'),
    path('generate-referral-code/', views.generate_referral_code_view, name='generate_referral_code_view'),
    path('schedule/', views.scheduletemp, name='schedule'),
    path('prescriptions/', views.prescriptions, name='prescriptions'),
    path('messages/', views.messages, name='messages'),
    path('messages/<int:id>/', views.conversation, name='conversation'),
    path('delete_prescription/<int:id>/', views.delete_prescription, name='delete_prescription'),
    path('edit_prescription/<int:id>/', views.prescription_form, name='edit_prescription'),
    path('add_prescription/', views.add_prescription_form, name='add_prescription'),
    path('prescriptions_invoice/', views.prescriptions_invoice_view, name='prescriptions_invoice_view'),
    path('delete_appointment/<int:id>/', views.delete_appointment, name='delete_appointment'),
    path('edit_appointment/<int:id>/', views.appointment_form, name='edit_appointment'),
    path('add_appointment/', views.add_appointment_form, name='add_appointment'),
    path('add_group/', views.add_group, name='add_group'),
    path('users/<int:id>/', views.medical_information, name='medical_information'),
    path('users/me/', views.my_medical_information, name='my_medical_information'),
    path('signup/', views.signup, name='signup'),
    path('welcome/', views.welcome_view, name='welcome_view'),  # Ensure the name matches
    path('users/<int:id>/info.json/', views.export, name='export'),
    path('users/me/info.json/', views.export_me, name='export_me'),
    path('users/', views.users, name='users'),
    path('logs/', views.logs, name='logs'),
    path('profile/', views.profile, name='profile'),
    path('update-profile-picture/', views.update_profile_picture, name='update_profile_picture'),
    path('dashboard/', views.dashboard_view, name='dashboard'),  
    path('map/', views.map_view, name='map'),  
    path('flight/', views.demo, name='demo'),
    path('flight-time/', views.flight_time_view, name='flight_time'),
    path('book_flight/<str:flight>/', views.book_flight, name='book_flight'),
    path('origin_airport_search/', views.origin_airport_search, name='origin_airport_search'),
    path('destination_airport_search/', views.destination_airport_search, name='destination_airport_search'),
    path('get_currency_code/', views.get_currency_code_ajax, name='get_currency_code'),
    path('upload_id_and_save/', views.upload_id_and_save, name='upload_id_and_save'),
    path('ocr_uploaded_document/', views.ocr_uploaded_document, name='ocr_uploaded_document'),
    path('billing/', views.billing_view, name='billing'),
    path('transfers/', views.transfers, name='transfers'),
    path('virtual-reality/', views.virtual_reality, name='virtual-reality'),
    path('salesdash/', views.salesdash, name='salesdash'),
    path('project/', views.project, name='project'),
    path('product/', views.product_list, name='product'),
    path('product/<slug:slug>/', views.product_detail, name='product_detail'),
    path('reverse_geocode/', views.reverse_geocode, name='reverse_geocode'),
    path('marketing/', views.marketing_view, name='marketing'),
    path('serp/', views.serp_view, name='serp'),
    path('privacypolicy/', views.privacypolicy, name='privacypolicy'),
    path('TermsofService/', views.TermsofService, name='TermsofService'),
    path('streamlit_embed/', views.streamlit_embed, name='streamlit_embed'),
    path('microsofter/', views.microsofter, name='microsofter'),
    path('user-table/', views.user_list_view, name='user_table'),
    path('preview-error/', errors.preview_error, name='preview_error'),

    # Treatment Plan URLs
    path('ndash/', mew.ndashboard_view, name='ndash'),
    path('patients/', mew.list_patients, name='list_patients'),
    path('patients/<int:patient_id>/', mew.patient_detail, name='patient_detail'),  # URL pattern for patient detail
    path('patients/<int:patient_id>/treatment-plan/new/', TreatmentPlanview.create_treatment_plan, name='create_treatment_plan'),
    path('treatment-plan/<int:treatment_plan_id>/', TreatmentPlanview.TreatmentPlanDetailView.as_view(), name='treatment_plan_detail'),
    path('treatment-plan/<int:treatment_plan_id>/edit/', TreatmentPlanview.edit_treatment_plan, name='edit_treatment_plan'),
    path('treatment-plan/<int:pk>/delete/', mew.delete_treatment_plan, name='delete_treatment_plan'),
    path('treatment-plan/<int:pk>/api/', mew.treatment_plan_api, name='treatment_plan_api'),
    path('my-treatment-plans/', mew.my_treatment_plans, name='my_treatment_plans'),
    path('my-treatment-plans/download/', mew.download_treatment_plan_pdf, name='download_treatment_plan_pdf'),

    # Language switcher
    path('set_language/', views.set_language, name='set_language'),
    path('dataviz/', comprehensive_dashboard, name='comprehensive_dashboard'),

    
    # =============================================================================
    # INVOICE NINJA INTEGRATION API ENDPOINTS
    # =============================================================================
    
    # Callback endpoint for Invoice Ninja client creation
    path('api/invoice-ninja/client-created/', 
         invoice_ninja_views.invoice_ninja_client_created_callback, 
         name='invoice_ninja_client_created_callback'),
    
    # Bulk sync callback endpoint
    path('api/invoice-ninja/bulk-sync/', 
         invoice_ninja_views.invoice_ninja_bulk_sync_callback, 
         name='invoice_ninja_bulk_sync_callback'),
    
    # Get sync status for a specific user
    path('api/invoice-ninja/sync-status/<int:user_id>/', 
         invoice_ninja_views.invoice_ninja_sync_status, 
         name='invoice_ninja_sync_status'),
    
    # Get list of users pending synchronization
    path('api/invoice-ninja/pending-users/', 
         invoice_ninja_views.invoice_ninja_pending_users, 
         name='invoice_ninja_pending_users'),
    
    # Manually retry synchronization for a specific user
    path('api/invoice-ninja/retry-sync/<int:user_id>/', 
         invoice_ninja_views.invoice_ninja_retry_sync, 
         name='invoice_ninja_retry_sync'),
    
    # Temporary debug route to check user existence
    path('debug/check-users/', views.debug_check_users, name='debug_check_users'),

]   



if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
