# Standard library imports
import os
import datetime
import json
import time
import ast
import logging
import io

# Set up logger
logger = logging.getLogger(__name__)


# Django imports
from django.conf import settings
from django.shortcuts import render, redirect, get_object_or_404
from django.utils import dateparse, timezone, translation
from django.urls import reverse
from django.core.exceptions import PermissionDenied
from django.contrib.admin.models import LogEntry
from django.contrib.auth import logout, login, authenticate, get_user_model
from django.views.decorators.csrf import csrf_exempt
from django.contrib.auth.models import Group
from django.contrib.auth.decorators import login_required, user_passes_test
from django.http import HttpResponse, JsonResponse
from django.db.models import Max
from django.core.files.storage import default_storage
from django.contrib import messages
from .referral_utils import handle_referral, get_or_create_referral_code 
from django.utils.http import url_has_allowed_host_and_scheme
from allauth.account.auth_backends import AuthenticationBackend
from django.core.exceptions import ValidationError
from allauth.account.utils import complete_signup
from allauth.account.signals import email_confirmed
from django.db import transaction
from allauth.account.utils import send_email_confirmation
from django.utils.translation import get_language, activate
from django.utils.translation import gettext as _
from django_countries import countries



# Third-party library imports
from amadeus import Client, ResponseError, Location
import airportsdata
import pycountry
# import pytesseract  # Commented out as it's not currently being used
from PIL import Image, ImageOps
from geopy.geocoders import Nominatim
from django.core.files.uploadedfile import InMemoryUploadedFile


# Local app imports
from . import form_utilities, checks
from .form_utilities import *
from .models import (
    MedicalInformation, Insurance, Hospital, HospitalStay, 
    EmergencyContact, Appointment, Prescription, MessageGroup, 
    Message, Subscription, Contact, MedicalFile, TreatmentPlan,
    TreatmentProduct
)
from .flight import Flight
from .booking import Booking
from django.views.decorators.csrf import csrf_protect

from .adminforms import UserAdminForm

import plotly.express as px
from allauth.account.signals import user_logged_in, user_signed_up
from django.dispatch import receiver

User = get_user_model()

def resize_profile_image(image_file, target_size=(300, 300)):
    """
    Resize and process profile image to standard size
    
    Args:
        image_file: Uploaded image file
        target_size: Tuple of (width, height) for target size
    
    Returns:
        InMemoryUploadedFile: Processed image file
    """
    try:
        # Open the uploaded image
        image = Image.open(image_file)
        
        # Fix image orientation based on EXIF data
        image = ImageOps.exif_transpose(image)
        
        # Convert RGBA to RGB if necessary (for PNG with transparency)
        if image.mode in ('RGBA', 'LA', 'P'):
            # Create a white background
            background = Image.new('RGB', image.size, (255, 255, 255))
            if image.mode == 'P':
                image = image.convert('RGBA')
            background.paste(image, mask=image.split()[-1] if image.mode == 'RGBA' else None)
            image = background
        elif image.mode != 'RGB':
            image = image.convert('RGB')
        
        # Resize image maintaining aspect ratio and crop to square
        image = ImageOps.fit(image, target_size, Image.Resampling.LANCZOS)
        
        # Create a BytesIO object to save the processed image
        output = io.BytesIO()
        
        # Save as JPEG with high quality
        image.save(output, format='JPEG', quality=90, optimize=True)
        output.seek(0)
        
        # Create a new InMemoryUploadedFile
        processed_file = InMemoryUploadedFile(
            output,
            'ImageField',
            f"{image_file.name.split('.')[0]}_resized.jpg",
            'image/jpeg',
            output.getbuffer().nbytes,
            None
        )
        
        return processed_file
        
    except Exception as e:
        logging.error(f"Error resizing image: {e}")
        raise e

def set_language(request):
    next_url = request.POST.get('next', request.GET.get('next'))
    if not next_url or not url_has_allowed_host_and_scheme(url=next_url, allowed_hosts={request.get_host()}):
        next_url = request.META.get('HTTP_REFERER', '/')

    response = redirect(next_url)
    lang_code = request.POST.get('language', request.GET.get('language'))
    if lang_code and lang_code in dict(settings.LANGUAGES).keys():
        if hasattr(request, 'session'):
            request.session['django_language'] = lang_code
        response.set_cookie(settings.LANGUAGE_COOKIE_NAME, lang_code)
        activate(lang_code)  # Activate the language immediately for the current request

    # Debugging output
    print(f"Session language: {request.session.get('django_language')}")
    print(f"Cookie language: {request.COOKIES.get(settings.LANGUAGE_COOKIE_NAME)}")
    print(f"Current language: {get_language()}")

    return response


#############################################################################################
##############################            allOuth             ###############################
#############################################################################################

# TEMPORARILY DISABLED TO PREVENT REDIRECT CONFLICTS
# @receiver(user_logged_in)
def custom_redirect_on_login_disabled(sender, request, user, **kwargs):
    """
    Custom redirect logic after a user logs in.
    DISABLED to prevent conflicts with login view redirects.
    """
    print(f"[DEBUG] Custom login redirect DISABLED for user {user.username}")
    return
    
    # Redirect to custom views based on your logic
    has_uploaded_files = MedicalFile.objects.filter(user=user).exists()

    if user.is_superuser:
        return redirect('/project/')
    elif has_uploaded_files:
        return redirect(reverse('app:dashboard'))
    else:
        return redirect(reverse('app:welcome_view'))

# TEMPORARILY DISABLED TO PREVENT REDIRECT CONFLICTS  
# @receiver(user_signed_up)
def custom_redirect_on_signup_disabled(sender, request, user, **kwargs):
    """
    Custom redirect logic after a user signs up.
    DISABLED to prevent conflicts with signup view redirects.
    """
    print(f"[DEBUG] Custom signup redirect DISABLED for user {user.username}")
    return redirect(reverse('app:welcome_view'))


#############################################################################################
##############################            login             ################################
#############################################################################################

def login_view(request):
    """
    Presents a simple form for logging in a user.
    If requested via POST, looks for the username and password,
    and attempts to log the user in. If the credentials are invalid,
    it passes an error message to the context which the template will
    render using a Bootstrap alert.

    :param request: The Django request object.
    :return: The rendered 'login' page.
    """
    context = {'navbar': 'login'}
    
    if request.method == 'POST':
        email = request.POST.get("email")
        password = request.POST.get("password")
        
        print(f"Login attempt - Email: {email}")  # Debug logging

        # Check if both email and password are provided
        if not all([email, password]):
            context['error_message'] = "You must provide an email and password."
            print("Missing email or password")  # Debug logging
        else:
            email = email.lower()  # Convert email to lowercase for consistency
            
            # Use our custom email authentication
            user = authenticate(request, username=email, password=password)
            
            print(f"Authentication result: {user}")  # Debug logging

            if user is None:
                context['error_message'] = "Invalid username or password."
                print("Authentication failed")  # Debug logging
            else:
                print(f"User authenticated successfully: {user.email}")  # Debug logging
                login(request, user)  # Log the user in
                
                remember = request.POST.get("remember")
                if remember is not None:
                    request.session.set_expiry(0)  # Session expires when browser closes

                # Check if the user has uploaded medical files
                has_uploaded_files = MedicalFile.objects.filter(user=user).exists()

                if user.is_superuser:
                    return redirect('/project/')  # Redirect superusers to /project/
                elif has_uploaded_files:
                    return redirect('app:dashboard')  # Redirect to dashboard if files are uploaded
                else:
                    return redirect(reverse('app:welcome_view'))  # Redirect to welcome if no files are uploaded

    return render(request, 'login.html', context)


def debug_check_users(request):
    """
    Temporary debug view to check user existence and authentication setup
    """
    from django.http import JsonResponse
    
    users = User.objects.all()[:10]  # Get first 10 users
    user_data = []
    
    for user in users:
        user_data.append({
            'id': user.id,
            'username': user.username,
            'email': user.email,
            'is_active': user.is_active,
            'is_superuser': user.is_superuser,
            'date_joined': user.date_joined.isoformat() if user.date_joined else None,
        })
    
    return JsonResponse({
        'total_users': User.objects.count(),
        'users': user_data,
        'auth_backends': getattr(settings, 'AUTHENTICATION_BACKENDS', []),
        'email_verification': getattr(settings, 'ACCOUNT_EMAIL_VERIFICATION', 'unknown'),
    })


def logout_view(request):
    """
    Logs the user out and redirects the user to the login page.
    :param request: The Django request.
    :return: A 301 redirect to the login page.
    """
    logout(request)
    return redirect('websites:home')

#############################################################################################
##############################            logout             ################################
#############################################################################################
from django.shortcuts import render
from django.contrib.auth.decorators import login_required
from .models import Accommodation, FlightReservation, PatientSchedule

@login_required
def dashboard_view(request):
    # Debug: Print statement to check if the view is being called
    print("Dashboard view has been called")

    user = request.user

    # Fetch relevant data for the dashboard
    accommodations = Accommodation.objects.filter(user=user)
    flight_reservations = FlightReservation.objects.filter(patientschedule__user=user).distinct()
    schedules = PatientSchedule.objects.filter(user=user)

    # Define context with translatable strings and data
    context = {
        'step_text_1': _('Here you can view and manage your new messages.'),
        'step_text_2': _('This section shows your upcoming appointments.'),
        'step_text_3': _('You can check your active prescriptions here.'),
        'step_text_4': _('This section shows your current balance.'),
        'accommodations': accommodations,
        'flight_reservations': flight_reservations,
        'schedules': schedules,
    }

    # Debug: Print context data
    for key, value in context.items():
        print(f"{key}: {value}")

    # Check if the request is an HTMX request
    if request.headers.get('HX-Request'):
        return render(request, 'partials/dashboard_content.html', context)
    else:
        return render(request, 'dashboard.html', context)

#############################################################################################
##############################            signup             ################################
#############################################################################################

from allauth.socialaccount.models import SocialApp
from django.urls import reverse


@csrf_protect
def signup(request):
    print('Signup view triggered')
    context = full_signup_context(None)
    context['is_signup'] = True

    # Fetch the Google login URL dynamically (handle missing URL pattern gracefully)
    try:
        google_login_url = reverse('socialaccount_login', args=['google'])
        context['google_login_url'] = google_login_url
    except Exception as e:
        print(f"Google login URL not available: {e}")
        context['google_login_url'] = None

    if request.method == 'POST':
        user, message = handle_user_form(request, request.POST)
        print(f'User form result: user={user}, message={message}')

        if user:
            # Set the backend attribute to specify which authentication backend was used
            # Since this is a new user registration, we'll use our custom EmailBackend
            user.backend = 'apps.backends.EmailBackend'
            login(request, user)
            print(f'User {user.username} logged in')

            # Email notifications disabled to prevent login blocking
            # send_email_confirmation_async(user)

            return redirect(reverse('app:welcome_view'))

        elif message:
            context['error_message'] = message
            print(f'Error: {message}')

    return render(request, 'signup.html', context)


def send_email_confirmation_async(user):
    # Email notifications disabled to prevent login blocking
    print(f'Email notifications disabled - user {user.email} registered successfully')


@login_required
def welcome_view(request):
    print('Welcome view triggered')

    user_count = User.objects.count()
    print(f'User count: {user_count}')

    if request.user.is_authenticated:
        print(f'Authenticated user: {request.user.username}')
    else:
        print('User is not authenticated')

    context = {
        'user_count': user_count,
        'user': request.user
    }
    return render(request, 'check_email.html', context)

def full_signup_context(user=None):
    """
    Returns a dictionary containing valid years, months, days, hospitals,
    groups in the database, and the list of countries for nationality.
    """
    return {
        "year_range": reversed(range(1900, datetime.date.today().year + 1)),
        "day_range": range(1, 32),
        "months": [
            "Jan", "Feb", "Mar", "Apr",
            "May", "Jun", "Jul", "Aug",
            "Sep", "Oct", "Nov", "Dec"
        ],
        "hospitals": Hospital.objects.all(),
        "groups": Group.objects.all(),
        "sexes": MedicalInformation.SEX_CHOICES,
        "user_sex_other": (user and user.medical_information and
                           user.medical_information.sex not in MedicalInformation.SEX_CHOICES),
        "countries": list(countries),  # List of available countries for the nationality field
    }


#############################################################################################
##############################            generics             ################################
#############################################################################################

@login_required
def billing_view(request):
    # Debug: Print statement to check if the view is being called
    print("Billing view called")

    # Define context with translatable strings for the billing page
    context = {
        'step_text_1': _("This is your card information, where you can see the details of your credit card."),
        'step_text_2': _("Here you can manage your payment methods, including adding new cards."),
        'step_text_3': _("This section shows your invoices, with options to view them as PDFs."),
        'step_text_4': _("Here you can find your billing information, with options to edit or delete."),
        'step_text_5': _("This area shows your transaction history, with details of the most recent activities."),
    }

    # Debug: Check if it's an HTMX request
    if request.headers.get('HX-Request'):
        print("HTMX request detected")
        # Try returning a simple response to isolate the problem
        return render(request, 'partials/billing_content.html', context)
    else:
        print("Normal request detected")
        # Render the full template (base.html + billing.html) for normal requests
        return render(request, 'billing.html', context)


@login_required
def map_view(request):
    return render(request, 'map.html')



@login_required
def serp_view(request):
    return render(request, 'chat.html')



@login_required
def project(request):
    # Your logic here
    return render(request, 'project_report.html')

@login_required
def marketing_view(request):
    # Define context variables for translatable text
    context = {
        'team_members_text': _("Team members:"),
        'go_to_serp_text': _("Go to SERP"),
        'next_events_text': _("Next events"),
        'productivity_text': _("Productivity"),
        'productivity_increase_text': _("4% more"),
        'in_2024_text': _("in 2024"),
        'marketing_phase_text': _("Marketing, Phase 1: Data Mining"),
        'action_text': _("Action"),
        'another_action_text': _("Another action"),
        'something_else_text': _("Something else here"),
        'visitors_text': _("Visitors"),
        'month_labels': [
            _("Apr"), _("May"), _("Jun"), _("Jul"), _("Aug"), _("Sep"), 
            _("Oct"), _("Nov"), _("Dec")
        ],
    }

    return render(request, 'marketing.html', context)

@login_required
def scheduletemp(request):
    user = request.user
    print(f"Fetching data for user: {user.username}")

    # Fetch accommodations for the user
    accommodations = Accommodation.objects.filter(user=user)
    print(f"Accommodations fetched: {list(accommodations)}")

    # Fetch flight reservations related to the user's schedules
    flight_reservations = FlightReservation.objects.filter(patientschedule__user=user).distinct()
    print(f"Flight Reservations fetched: {list(flight_reservations)}")

    # Fetch all patient schedules for the user
    schedules = PatientSchedule.objects.filter(user=user)
    print(f"Patient Schedules fetched: {list(schedules)}")

    # Prepare events for the calendar
    events = []
    for schedule in schedules:
        print(f"Processing schedule for user: {schedule.user}, Appointment Date: {schedule.appointment.date}")

        # Event 1: Arrival
        if schedule.flight_reservation:
            arrival_event = {
                'title': _("Arrival in Istanbul"),
                'start': f"{schedule.flight_reservation.arrival_date}T{schedule.flight_reservation.arrival_hour}",
                'className': 'bg-gradient-info',
                'info': f"Flight: {schedule.flight_reservation.arrival_flight_number}, Airline: {schedule.flight_reservation.arrival_flight_number}"
            }
            events.append(arrival_event)
            print(f"Added arrival event: {arrival_event}")

        # Event 2: Appointment
        appointment_event = {
            'title': _("Appointment with Doctor"),
            'start': schedule.appointment.date.isoformat(),
            'className': 'bg-gradient-success',
            'info': f"Doctor: {schedule.appointment.doctor.get_full_name()}, Location: {schedule.hospital.name if schedule.hospital else 'N/A'}"
        }
        events.append(appointment_event)
        print(f"Added appointment event: {appointment_event}")

        # Event 3: Departure
        if schedule.flight_reservation:
            departure_event = {
                'title': _("Departure from Istanbul"),
                'start': f"{schedule.flight_reservation.departure_date}T{schedule.flight_reservation.departure_hour}",
                'className': 'bg-gradient-info',
                'info': f"Flight: {schedule.flight_reservation.departure_flight_number}, Airline: {schedule.flight_reservation.departure_flight_number}"
            }
            events.append(departure_event)
            print(f"Added departure event: {departure_event}")

    print("Final events passed to template:")
    for event in events:
        print(event)

    return render(request, 'scheduletemp.html', {'events': events})

@login_required
def product_list(request):
    from collections import OrderedDict
    
    # Get all active products with slugs
    products = TreatmentProduct.objects.filter(is_active=True, slug__isnull=False).exclude(slug='')
    
    # Group products by category
    products_by_category = OrderedDict()
    
    # Get categories from CATEGORY_CHOICES and group products
    for category_value, category_display in TreatmentProduct.CATEGORY_CHOICES:
        category_products = products.filter(category=category_value)
        if category_products.exists():
            products_by_category[category_display] = category_products
    
    return render(request, 'product_list.html', {
        'products': products,
        'products_by_category': products_by_category
    })

@login_required
def product_detail(request, slug):
    product = get_object_or_404(TreatmentProduct, slug=slug, is_active=True)
    return render(request, 'product_detail.html', {'product': product})




#############################################################################################
##############################            user-specific      ################################
#############################################################################################




def handle_prescription_form(request, body, prescription=None):
    name = body.get("name")
    dosage = body.get("dosage")
    patient = body.get("patient")
    directions = body.get("directions")
    if not all([name, dosage, patient, directions]):
        return None, "All fields are required."
    try:
        patient = User.objects.get(pk=int(patient))
    except ValueError:
        return None, "We could not find the user specified."

    if prescription:
        changed_fields = []
        if prescription.name != name:
            changed_fields.append('name')
            prescription.name = name
        if prescription.dosage != dosage:
            changed_fields.append('dosage')
            prescription.dosage = dosage
        if prescription.directions != directions:
            changed_fields.append('directions')
            prescription.directions = directions
        if prescription.patient != patient:
            changed_fields.append('patient')
            prescription.patient = patient
        prescription.save()
        change(request, prescription, changed_fields)
    else:
        prescription = Prescription.objects.create(name=name, dosage=dosage,
                                                   patient=patient, directions=directions,
                                                   prescribed=timezone.now(), active=True)

        if not prescription:
            return None, "We could not create that prescription. Please try again."
        addition(request, prescription)
    return prescription, None

def get_referral_link(request):
    if request.method == 'POST':
        try:
            user = request.user
            referral_code = get_or_create_referral_code()
            user.referral_code = referral_code
            user.save()
            return JsonResponse({'success': True, 'referral_code': referral_code})
        except Exception as e:
            logger.error(f"Error generating referral code: {e}")
            return JsonResponse({'success': False, 'error': str(e)}, status=500)
    return JsonResponse({'success': False, 'error': 'Invalid request method'}, status=400)






@login_required
def prescriptions(request, error=None):
    """ 
    Renders a table of the prescriptions associated with this user.

    :param request: The Django request.
    :return: A rendered version of prescriptions.html
    """
    context = {
        "navbar": "prescriptions",
        "logged_in_user": request.user,
        "prescriptions": request.user.prescription_set.filter(active=True).all()
    }
    if error:
        context["error_message"] = error

    return render(request, 'prescriptions.html', context)


def add_prescription_form(request):
    return prescription_form(request, None)

@login_required
def prescriptions_invoice_view(request):
    user = request.user
    active_prescriptions = Prescription.objects.filter(patient=user, active=True)
    total_amount = 0
    prescriptions_with_amounts = []

    for prescription in active_prescriptions:
        try:
            dosage = float(prescription.dosage)
        except ValueError:
            dosage = 0
        qty = 1  # Assuming quantity is 1 since it's not defined in the model
        amount = dosage * qty
        prescriptions_with_amounts.append({
            'name': prescription.name,
            'dosage': prescription.dosage,
            'qty': qty,
            'amount': amount
        })
        total_amount += amount

    context = {
        'user': user,
        'prescriptions': prescriptions_with_amounts,
        'total_amount': total_amount,
        'invoice': {
            'number': '0453119',
            'date': '06/03/2019',
            'due_date': '11/03/2019',
        },
    }
    return render(request, 'prescriptions.html', context)



def prescription_form(request, prescription_id):
    prescription = None
    if prescription_id:
        prescription = get_object_or_404(Prescription, pk=prescription_id)
    if request.POST:
        if not request.user.can_add_prescription():
            raise PermissionDenied
        p, message = handle_prescription_form(request, request.POST, prescription)
        return prescriptions(request, error=message)
    context = {
        'prescription': prescription,
        'logged_in_user': request.user
    }
    return render(request, 'edit_prescription.html', context)


def delete_prescription(request, prescription_id):
    p = get_object_or_404(Prescription, pk=prescription_id)
    p.active = False
    p.save()
    deletion(request, p, repr(p))
    return redirect('app:prescriptions')



#############################################################################################
##############################            /signup             ################################
#############################################################################################

@login_required
def add_group(request):
    message = None
    if request.POST:
        group, message = handle_add_group_form(request, request.POST)
        if group:
            addition(request, group)
            return redirect('app:conversation', group.pk)
    return messages(request, error=message)


@login_required
def conversation(request, id):
    group = get_object_or_404(MessageGroup, pk=id)
    
    # Handle POST request for sending new messages
    if request.method == 'POST':
        message_body = request.POST.get('message')
        if message_body:
            # Create new message
            new_message = Message.objects.create(
                sender=request.user,
                group=group,
                body=message_body,
                date=timezone.now()
            )
            # Mark message as read by sender
            new_message.read_members.add(request.user)
            return redirect('app:conversation', id=id)
    
    messages_list = group.messages.all().order_by('date')
    
    # Mark all messages in this conversation as read by current user
    for message in messages_list:
        if request.user not in message.read_members.all():
            message.read_members.add(request.user)
    
    context = {
        'navbar': 'conversation',
        'group': group,
        'messages': messages_list,
        'user': request.user,
    }
    
    return render(request, 'conversation.html', context)


def handle_add_group_form(request, body):
    name = body.get('name')
    recipient_ids = body.getlist('recipient')
    message = body.get('message')

    if not all([name, recipient_ids, message]):
        return None, "All fields are required."
    if not [r for r in recipient_ids if r.isdigit()]:
        return None, "Invalid recipient."
    group = MessageGroup.objects.create(
        name=name
    )
    try:
        ids = [int(r) for r in recipient_ids]
        recipients = User.objects.filter(pk__in=ids)
    except User.DoesNotExist:
        return None, "Could not find user."
    group.members.add(request.user)
    for r in recipients:
        group.members.add(r)
    group.save()
    Message.objects.create(sender=request.user, body=message,
                           group=group, date=timezone.now())
    return group, None


@login_required
def my_medical_information(request):
    """
    Gets the primary key of the current user and redirects to the medical_information view
    for the logged-in user.
    :param request:
    :return:
    """
    return medical_information(request, request.user.pk)



@login_required
def medical_information(request, user_id):
    """
    Handles the display and editing of medical information for a user.
    """
    requested_user = get_object_or_404(User, pk=user_id)
    is_editing_own_medical_information = requested_user == request.user

    if not is_editing_own_medical_information and not request.user.can_edit_user(requested_user):
        raise PermissionDenied

    context = full_signup_context(requested_user)  # Assuming this function provides other needed context

    if request.method == 'POST':
        user, message = handle_user_form(request, request.POST, user=requested_user)
        if user:
            return redirect('app:medical_information', user.pk)
        elif message:
            context['error_message'] = message

    # Get all files uploaded by the requested_user
    uploaded_files = MedicalFile.objects.filter(user=requested_user)
    context['uploaded_files'] = uploaded_files

    context["requested_user"] = requested_user
    context["user"] = request.user
    context["requested_hospital"] = requested_user.hospital()
    context['is_signup'] = True
    context["navbar"] = "my_medical_information" if is_editing_own_medical_information else "medical_information"

    return render(request, 'medical_information.html', context)



import os
from django.conf import settings
from django.core.files import File

def handle_user_form(request, body, user=None):
    try:
        patient_group = Group.objects.get(name='Patient')
    except Group.DoesNotExist:
        patient_group = Group.objects.create(name='Patient')

    password = body.get("password")
    first_name = body.get("first_name")
    last_name = body.get("last_name")
    email = body.get("email").lower()
    group = body.get("group")
    phone = form_utilities.sanitize_phone(body.get("phone_number"))
    hospital_key = body.get("hospital")
    hospital = Hospital.objects.get(pk=int(hospital_key)) if hospital_key else None
    policy = body.get("policy")
    company = body.get("company")
    sex = body.get("sex")
    other_sex = body.get("other_sex")
    validated_sex = sex if sex in dict(MedicalInformation.SEX_CHOICES).keys() else other_sex
    medications = body.get("medications")
    allergies = body.get("allergies")
    medical_conditions = body.get("medical_conditions")
    family_history = body.get("family_history")
    additional_info = body.get("additional_info")
    referral_code = body.get("referral_code")

    # Handle file upload
    pic = request.FILES.get("thumbnail")

    if not all([first_name, last_name, email, phone]):
        return None, "All fields are required."

    if not form_utilities.email_is_valid(email):
        return None, "Invalid email."

    if user:
        user.email = email
        user.phone_number = phone
        user.first_name = first_name
        user.last_name = last_name

        if pic:
            # Resize the uploaded image before saving
            try:
                resized_pic = resize_profile_image(pic)
                user.thumbnail.save(resized_pic.name, resized_pic)
            except Exception as e:
                logging.error(f"Error resizing profile image: {e}")
                # Fall back to original image if resizing fails
                user.thumbnail.save(pic.name, pic)
        else:
            # Assign default profile picture if none is provided
            if not user.thumbnail:
                default_pic_path = os.path.join(settings.MEDIA_ROOT, 'profile_pictures/Profile-PNG-Photo.png')
                with open(default_pic_path, 'rb') as default_pic:
                    user.thumbnail.save('Profile-PNG-Photo.png', File(default_pic))

        if user.medical_information:
            user.medical_information.sex = validated_sex
            user.medical_information.medical_conditions = medical_conditions
            user.medical_information.family_history = family_history
            user.medical_information.additional_info = additional_info
            user.medical_information.allergies = allergies
            user.medical_information.medications = medications
            if user.medical_information.insurance:
                user.medical_information.insurance.policy_number = policy
                user.medical_information.insurance.company = company
                user.medical_information.insurance.save()
            else:
                user.medical_information.insurance = Insurance.objects.create(
                    policy_number=policy, company=company
                )
                addition(request, user.medical_information.insurance)
            user.medical_information.save()
            change(request, user.medical_information, 'Changed fields.')
        else:
            insurance = Insurance.objects.create(policy_number=policy, company=company)
            addition(request, insurance)
            medical_information = MedicalInformation.objects.create(
                allergies=allergies, family_history=family_history, sex=validated_sex,
                medications=medications, additional_info=additional_info, insurance=insurance,
                medical_conditions=medical_conditions
            )
            addition(request, user.medical_information)
            user.medical_information = medical_information

        if hospital and not HospitalStay.objects.filter(patient=user, hospital=hospital, discharge__isnull=True).exists():
            hospital.admit(user)

        if user.is_superuser:
            if not user.groups.filter(pk=group.pk).exists():
                for user_group in user.groups.all():
                    user_group.user_set.remove(user)
                    user_group.save()
                group.user_set.add(user)
                group.save()

        user.save()
        change(request, user, 'Changed fields.')
        return user, None
    else:
        if get_user_model().objects.filter(email=email).exists():
            return None, "A user with that email already exists."

        insurance = Insurance.objects.create(policy_number=policy, company=company)
        medical_information = MedicalInformation.objects.create(
            allergies=allergies, family_history=family_history, sex=validated_sex,
            medications=medications, additional_info=additional_info, insurance=insurance,
            medical_conditions=medical_conditions
        )
        user = get_user_model().objects.create_user(
            username=email, email=email, password=password, first_name=first_name,
            last_name=last_name, phone_number=phone, medical_information=medical_information
        )
        if not referral_code:
            referral_code = get_or_create_referral_code(user)
        else:
            if not handle_referral(user, referral_code):
                return None, "Invalid referral code"

        if pic:
            # Resize the uploaded image before saving
            try:
                resized_pic = resize_profile_image(pic)
                user.thumbnail.save(resized_pic.name, resized_pic)
            except Exception as e:
                logging.error(f"Error resizing profile image: {e}")
                # Fall back to original image if resizing fails
                user.thumbnail.save(pic.name, pic)
        else:
            # Assign default profile picture if none is provided
            default_pic_path = os.path.join(settings.MEDIA_ROOT, 'profile_pictures/Profile-PNG-Photo.png')
            with open(default_pic_path, 'rb') as default_pic:
                user.thumbnail.save('Profile-PNG-Photo.png', File(default_pic))

        if hospital:
            hospital.admit(user)
        request.user = user
        addition(request, user)
        addition(request, medical_information)
        addition(request, insurance)
        patient_group.user_set.add(user)
        return user, None



@login_required
def messages(request, error=None):
    other_groups = ['Patient', 'Doctor', 'Nurse']
    if not request.user.is_superuser:
        user_group = request.user.groups.first()
        if user_group and user_group.name in other_groups:
            other_groups.remove(user_group.name)
    
    recipients = get_user_model().objects.filter(groups__name__in=other_groups)
    message_groups = request.user.messagegroup_set.annotate(max_date=Max('messages__date')).order_by('-max_date').all()
    
    for group in message_groups:
        group.has_unread = any(request.user not in message.read_members.all() for message in group.messages.all())
    
    context = {
        'navbar': 'messages',
        'user': request.user,
        'recipients': recipients,
        'groups': message_groups,
        'error_message': error
    }
    return render(request, 'messages.html', context)


@login_required
def users(request):
    try:
        # Assuming `hospital` is a method or property on the user model
        hospital = request.user.hospital()
        if hospital is None:
            raise AttributeError("User has no associated hospital")

        doctors = hospital.users_in_group('Doctor')
        patients = hospital.users_in_group('Patient')
        nurses = hospital.users_in_group('Nurse')

        context = {
            'navbar': 'users',
            'doctors': doctors,
            'nurses': nurses,
            'patients': patients
        }
        return render(request, 'users.html', context)

    except AttributeError as e:
        # Handle the case where `hospital` is None or `users_in_group` does not exist
        return render(request, 'error.html', {'message': str(e)})

    except Exception as e:
        # Handle any other unexpected exceptions
        return render(request, 'error.html', {'message': 'An unexpected error occurred: ' + str(e)})

# Ensure that your user model has a method or property named `hospital`
# For example, if you are using a custom user model, it might look something like this:

# models.py
    def hospital(self):
        return self.hospital


def handle_appointment_form(request, body, user, appointment=None):
    """
    Validates the provided fields for an appointment request and creates one
    if all fields are valid.
    :param body: The HTTP form body containing the fields.
    :param user: The user intending to create the appointment.
    :return: A tuple containing either a valid appointment or failure message.
    """
    date_string = body.get("date")
    try:
        parsed = dateparse.parse_datetime(date_string)
        if not parsed:
            return None, "Invalid date or time."
        parsed = timezone.make_aware(parsed, timezone.get_current_timezone())
    except:
        return None, "Invalid date or time."
    duration = int(body.get("duration"))
    doctor_id = int(body.get("doctor", user.pk))
    doctor = User.objects.get(pk=doctor_id)
    patient_id = int(body.get("patient", user.pk))
    patient = User.objects.get(pk=patient_id)

    is_change = appointment is not None

    changed = []
    if is_change:
        if appointment.date != parsed:
            changed.append('date')
        if appointment.patient != patient:
            changed.append('patient')
        if appointment.duration != duration:
            changed.append('duration')
        if appointment.doctor != doctor:
            changed.append('doctor')
        appointment.delete()
    if not doctor.is_free(parsed, duration):
        return None, "The doctor is not free at that time." +\
                     " Please specify a different time."

    if not patient.is_free(parsed, duration):
        return None, "The patient is not free at that time." +\
                     " Please specify a different time."
    appointment = Appointment.objects.create(date=parsed, duration=duration,
                                             doctor=doctor, patient=patient)

    if is_change:
        change(request, appointment, changed)
    else:
        addition(request, appointment)
    if not appointment:
        return None, "We could not create the appointment. Please try again."
    return appointment, None


@login_required
def appointment_form(request, appointment_id):
    appointment = None
    if appointment_id:
        appointment = get_object_or_404(Appointment, pk=appointment_id)
    if request.POST:
        appointment, message = handle_appointment_form(
            request, request.POST,
            request.user, appointment=appointment
        )
        return schedule(request, error=message)
    hospital = request.user.hospital()
    context = {
        "user": request.user,
        'appointment': appointment,
        "doctors": hospital.users_in_group('Doctor'),
        "patients": hospital.users_in_group('Patient')
    }
    return render(request, 'edit_appointment.html', context)


@login_required
def schedule(request, error=None):
    """
    Renders a page with an HTML form allowing the user to add an appointment
    with an existing doctor.
    Also shows a table of the existing appointments for the logged-in user.
    """
    now = timezone.now()
    
    try:
        hospital = request.user.hospital()
        if not hospital:
            raise AttributeError("User has no associated hospital.")
        
        doctors = hospital.users_in_group('Doctor')
        patients = hospital.users_in_group('Patient')
        
        context = {
            "navbar": "schedule",
            "user": request.user,
            "doctors": doctors,
            "patients": patients,
            "schedule_future": request.user.schedule().filter(date__gte=now).order_by('date'),
            "schedule_past": request.user.schedule().filter(date__lt=now).order_by('-date')
        }
        if error:
            context['error_message'] = error
        
        return render(request, 'schedule.html', context)
    
    except AttributeError as e:
        # Handle the case where hospital is None or any other attribute error
        return render(request, 'schedule.html', {
            "error_message": str(e)
        })

    except Exception as e:
        # Handle any other exceptions that may occur
        return render(request, 'schedule.html', {
            "error_message": "An unexpected error occurred: " + str(e)
        })


@login_required
def add_appointment_form(request):
    return appointment_form(request, None)


@login_required
def delete_appointment(request, appointment_id):
    a = get_object_or_404(Appointment, pk=appointment_id)
    a.delete()
    return redirect('app:schedule')




def home1(request):
    user = get_user_model().objects.all()
    context = {
        'user':user
    }
    if request.method =="POST": 
        if 'subs' in request.POST: 
            email = request.POST["contact"]
            sub = Subscription()
            sub.email = email
            sub.save()
        else:
            fname = request.POST["first_name"]
            lname = request.POST["last_name"]
            email = request.POST["email"]
            phone = request.POST["phone"]
            messages = request.POST["message"]
            new_message = Contact()
            new_message.first_name=fname
            new_message.last_name=lname
            new_message.email=email
            new_message.phone=phone
            new_message.message=messages
            new_message.save()

    return render(request, 'index1.html',context)


@login_required
def profile(request):
    user = request.user._wrapped if hasattr(request.user, '_wrapped') else request.user

    unread_count = 0
    user_hospital = None

    if hasattr(user, 'unread_message_count') and callable(getattr(user, 'unread_message_count', None)):
        unread_count = user.unread_message_count()

    if hasattr(user, 'hospital') and callable(getattr(user, 'hospital', None)):
        user_hospital = user.hospital()

    context = {
        'unread_count': unread_count,
        'hospital': user_hospital,
        'requested_user': user,
        'groups': Group.objects.all(),
        'hospitals': Hospital.objects.all(),
        'countries': list(countries),  # Assuming you have a function to get the country list
        'months': range(1, 13),
        'day_range': range(1, 32),
        'year_range': range(1900, datetime.datetime.now().year + 1),
        'sexes': dict(MedicalInformation.SEX_CHOICES).keys(),
    }

    if request.method == 'POST':
        user, error = handle_user_form(request, request.POST, user)
        if error:
            context['error'] = error
        else:
            context['success'] = _("Profile updated successfully.")
            # Reload the user    to reflect the changes
            user = get_user_model().objects.get(pk=user.pk)
            context['requested_user'] = user

    return render(request, 'profile_improved.html', context)
     

@login_required
def transfers(request):
    return render(request, 'transfers.html')

@login_required
def virtual_reality(request):
   return render(request, 'virtual-reality.html')

def salesdash(request):
    context = {
        'step_text_1': _("This is your profile card, showing your role and basic information."),
        'step_text_2': _("Here are the user stories, where you can view and add stories."),
        'step_text_3': _("This section displays a post by one of your colleagues."),
        'step_text_4': _("This card shows the details of the Patient Care Team."),
        'step_text_5': _("This card shows your upcoming Slack meeting."),
        'step_text_6': _("This card shows your upcoming Invision meeting."),
    }
    return render(request, 'salesdash.html', context)



@login_required
def export_me(request):
    return export(request, request.user.pk)


@login_required
def export(request, id):
    user = get_object_or_404(User, pk=id)
    if user != request.user and not request.user.is_superuser:
        raise PermissionDenied
    json_object = json.dumps(user.json_object(), sort_keys=True,
                             indent=4, separators=(',', ': '))
    return HttpResponse(json_object,
                        content_type='application/force-download')

amadeus = Client(
    client_id=settings.AMADEUS_CLIENT_ID,
    client_secret=settings.AMADEUS_CLIENT_SECRET
)


# Load the airport data
airports = airportsdata.load('IATA')

def demo(request):
    currency_code = "EUR"  # Default currency code
    if request.method == "POST":
        print("=== OLD WORKING SETUP DEBUG: POST request received ===")
        print(f"Request method: {request.method}")
        print(f"Content type: {request.content_type}")
        print(f"POST data: {dict(request.POST)}")
        print(f"User: {request.user}")
        
        # Retrieve data from the UI form
        origin = request.POST.get("Origin")
        destination = request.POST.get("Destination")
        departure_date = request.POST.get("Departuredate")
        return_date = request.POST.get("Returndate")

        print(f"=== OLD WORKING SETUP: Form data extraction ===")
        print(f"Origin: '{origin}'")
        print(f"Destination: '{destination}'")
        print(f"Departure date: '{departure_date}'")
        print(f"Return date: '{return_date}'")

        # Get the currency code
        currency_code = get_currency_code(origin)
        print(f"Currency code: {currency_code}")

        # Prepare URL parameters for search
        kwargs = {
            "originLocationCode": origin,
            "destinationLocationCode": destination,
            "departureDate": departure_date,
            "adults": 1,
            "currencyCode": currency_code  # Use PYCOUNTRY to get currency code
        }

        if return_date:
            kwargs["returnDate"] = return_date
            
        print(f"=== OLD WORKING SETUP: API parameters ===")
        print(f"kwargs: {kwargs}")
        print(f"Amadeus client: {amadeus}")
        print(f"Client ID: {amadeus.client_id[:8]}...")

        # Perform flight search based on previous inputs
        if origin and destination and departure_date:
            print("=== OLD WORKING SETUP: Making API call ===")
            try:
                print("Calling amadeus.shopping.flight_offers_search.get(**kwargs)")
                search_flights = amadeus.shopping.flight_offers_search.get(**kwargs)
                print(f"=== OLD WORKING SETUP: API SUCCESS ===")
                print(f"Response type: {type(search_flights)}")
                print(f"Data length: {len(search_flights.data) if search_flights.data else 0}")
                
            except ResponseError as error:
                print(f"=== OLD WORKING SETUP: API ERROR ===")
                print(f"Error type: {type(error)}")
                print(f"Error: {error}")
                print(f"Error response: {error.response}")
                try:
                    error_detail = error.response.result["errors"][0]["detail"]
                    print(f"Error detail: {error_detail}")
                except:
                    print("Could not extract error detail")
                messages.add_message(
                    request, messages.ERROR, error.response.result["errors"][0]["detail"]
                )
                return render(request, "demo/home.html", {})
                
            search_flights_returned = []
            response = ""
            print("=== OLD WORKING SETUP: Processing flights ===")
            for i, flight in enumerate(search_flights.data):
                print(f"Processing flight {i+1}")
                offer = Flight(flight).construct_flights()
                search_flights_returned.append(offer)
                response = zip(search_flights_returned, search_flights.data)
            
            print(f"=== OLD WORKING SETUP: Processed {len(search_flights_returned)} flights ===")
            print("=== OLD WORKING SETUP: Rendering results template ===")

            return render(
                request,
                "demo/results.html",
                {
                    "response": response,
                    "origin": origin,
                    "destination": destination,
                    "departureDate": departure_date,
                    "returnDate": return_date,
                    "currency_code": currency_code  # Add currency code to context
                },
            )
        else:
            print("=== OLD WORKING SETUP: Missing required fields ===")
            print(f"Origin: '{origin}', Destination: '{destination}', Departure: '{departure_date}'")
            
    print("=== OLD WORKING SETUP: Rendering home template ===")
    return render(request, "demo/home.html", {})

def get_currency_code(iata_code):
    print(f"Getting currency code for IATA: {iata_code}")  # Debugging statement
    airport = airports.get(iata_code)
    if airport:
        print(f"Airport data: {airport}")  # Debugging statement
        country_code = airport['country']
        country = pycountry.countries.get(alpha_2=country_code)
        if country:
            print(f"Country data: {country}")  # Debugging statement
            currency = pycountry.currencies.get(numeric=country.numeric)
            if currency:
                print(f"Currency data: {currency}")  # Debugging statement
                return currency.alpha_3
            else:
                print("Currency not found")  # Debugging statement
        else:
            print("Country not found")  # Debugging statement
    else:
        print("Airport not found")  # Debugging statement
    return "EUR"  # Default to eur  if currency cannot be determined

def get_currency_code_ajax(request):
    if request.headers.get('x-requested-with') == 'XMLHttpRequest':
        iata_code = request.GET.get("iata_code", "").strip().upper()
        print(f"Processing IATA code: {iata_code}")  # Debug
        
        airport = airports.get(iata_code)
        currency_code = get_currency_code(iata_code)
        
        # Get country code for flag display
        country_code = None
        country_name = None
        
        if airport and 'country' in airport:
            original_country_code = airport['country']
            country_code = original_country_code.lower()  # Convert to lowercase for flag file naming
            print(f"Country code from airport: {original_country_code} -> {country_code}")  # Debug
            
            country = pycountry.countries.get(alpha_2=original_country_code)
            if country:
                country_name = country.name
                print(f"Country name: {country_name}")  # Debug
            else:
                print(f"Country not found in pycountry for code: {original_country_code}")  # Debug
        else:
            print(f"Airport not found or missing country data for IATA: {iata_code}")  # Debug
        
        response_data = {
            "currency_code": currency_code,
            "country_code": country_code,
            "country_name": country_name,
            "iata_code": iata_code  # Include for debugging
        }
        
        print(f"Returning response: {response_data}")  # Debug
        return JsonResponse(response_data, safe=False)
    
    return JsonResponse({"error": "Invalid request"}, status=400)


def flight_time_view(request):
    """
    View function to render the flight time demo page.
    This displays an interactive 3D earth with flight path visualization.
    """
    return render(request, 'flight-time.html')


def generate_flight_invoice(request):
    """
    Generate a beautiful flight invoice after booking
    """
    if request.method == 'POST':
        try:
            # Get booking data from the form
            flight1_date = request.POST.get('flight1Date')
            flight1_class = request.POST.get('flight1Class', 'Economy')
            flight2_date = request.POST.get('flight2Date')
            flight2_class = request.POST.get('flight2Class', 'Economy')
            
            # Get passenger details
            email = request.POST.get('email')
            mobile = request.POST.get('mobile')
            country_code = request.POST.get('countryCode')
            passengers_count = request.POST.get('passengersCount', '1')
            
            # Get raw flight data
            raw_flight_data = request.POST.get('raw_flight_data')
            
            print("=== INVOICE GENERATION DEBUG ===")
            print(f"Flight 1 Date: {flight1_date}")
            print(f"Flight 1 Class: {flight1_class}")
            print(f"Email: {email}")
            print(f"Mobile: {mobile}")
            print(f"Passengers: {passengers_count}")
            
            # Create a beautiful invoice context
            from datetime import datetime
            invoice_data = {
                'invoice_number': f"INV-{datetime.now().strftime('%Y%m%d%H%M%S')}",
                'date': datetime.now().strftime('%B %d, %Y'),
                'customer_email': email,
                'customer_phone': f"+{country_code} {mobile}" if country_code and mobile else mobile,
                'passengers_count': passengers_count,
                'flight1_date': flight1_date,
                'flight1_class': flight1_class,
                'flight2_date': flight2_date,
                'flight2_class': flight2_class,
                'booking_status': 'Confirmed',
                'total_amount': '€1,250.00',  # This would come from the actual booking
                'currency': 'EUR',
                'confirmation_code': f"CONF-{datetime.now().strftime('%Y%m%d%H%M')}",
            }
            
            # Create passenger list
            passengers = []
            for i in range(int(passengers_count)):
                passengers.append({
                    'name': f"Passenger {i+1}",
                    'type': 'Adult',
                    'seat': f"{flight1_class}",
                })
            
            invoice_data['passengers'] = passengers
            
            print(f"Invoice data: {invoice_data}")
            
            # Render the beautiful invoice template
            return render(request, "demo/flight_invoice.html", {
                'invoice': invoice_data,
                'success': True,
                'message': 'Your booking has been confirmed! Here is your beautiful invoice.'
            })
            
        except Exception as error:
            print(f"Invoice generation error: {error}")
            return render(request, "demo/flight_invoice.html", {
                'error': True,
                'message': f'There was an error generating your invoice: {str(error)}'
            })
    
    # If not POST, redirect to flight search
    return redirect('app:demo')


def book_flight_enhanced(request, flight):
    """
    Enhanced booking view that directly generates a professional PDF invoice
    using the logged-in user's database information + fake flight data
    """
    if not request.user.is_authenticated:
        return redirect('app:login')
    
    try:
        # Import the PDF generation utilities
        from flights.pdf_utils import render_to_pdf, generate_ticket_reference
        from django.template.loader import get_template
        from django.http import HttpResponse
        from io import BytesIO
        
        def safe_get(obj, key_path, default="N/A"):
            """
            Safely get nested values from objects/dictionaries with fallback to default.
            
            Examples:
            safe_get(user, 'profile.address.city') -> user.profile.address.city or "N/A"
            safe_get(data, 'flight.details.price') -> data['flight']['details']['price'] or "N/A"
            """
            try:
                if obj is None:
                    return default
                    
                keys = key_path.split('.')
                current = obj
                
                for key in keys:
                    if hasattr(current, key):
                        current = getattr(current, key)
                    elif isinstance(current, dict) and key in current:
                        current = current[key]
                    else:
                        return default
                        
                # Return the value or default if it's None/emptyap  
                return current if current not in [None, "", []] else default
            except:
                return default
        
        def make_safe_context(context_dict):
            """
            Create a safe context that handles missing entries gracefully.
            Wraps the context with error handling for template rendering.
            """
            class SafeContext(dict):
                def __getitem__(self, key):
                    try:
                        return super().__getitem__(key)
                    except KeyError:
                        print(f"Warning: Missing context key '{key}', using 'N/A'")
                        return "N/A"
                
                def get(self, key, default="N/A"):
                    try:
                        return super().get(key, default)
                    except:
                        return default
            
            return SafeContext(context_dict)
        
        def simple_render_to_pdf(template_src, context_dict):
            """Simple PDF generation with better error handling"""
            try:
                from xhtml2pdf import pisa
                template = get_template(template_src)
                
                # Use safe context that handles missing entries
                safe_context = make_safe_context(context_dict)
                html = template.render(safe_context)
                result = BytesIO()
                
                # Try UTF-8 first, then fallback to ISO-8859-1
                try:
                    pdf = pisa.pisaDocument(BytesIO(html.encode("UTF-8")), result)
                except:
                    pdf = pisa.pisaDocument(BytesIO(html.encode("ISO-8859-1", errors='replace')), result)
                
                if not pdf.err:
                    return HttpResponse(result.getvalue(), content_type='application/pdf')
                else:
                    print(f"PDF errors: {pdf.err}")
                    return None
            except Exception as e:
                print(f"PDF generation exception: {e}")
                import traceback
                traceback.print_exc()
                return None
        
        # Get user information from database with safe access
        user = request.user
        
        # Create fake flight details for demo (since API isn't live)
        flight_details = {
            'flight_number': 'BJ131/BJ246',
            'route': 'ALG → TUN → FRA',
            'departure': '31 Jul 2025, 23:55',
            'arrival': '01 Aug 2025, 15:20',
            'duration': '14h 25m',
            'class': 'Economy',
            'airline': 'Nouvelair (BJ)',
            'price': '24,583.00',
            'currency': 'DZD'
        }
        
        # Generate unique reference number
        ref_no = generate_ticket_reference()
        
        # Generate invoice data using real user info + fake flight with safe access
        from datetime import datetime
        invoice_data = {
            'invoice_number': f"INV-{datetime.now().strftime('%Y%m%d%H%M%S')}",
            'ref_no': ref_no,
            'date': datetime.now().strftime('%B %d, %Y'),
            'customer_name': safe_get(user, 'first_name', 'Guest') + " " + safe_get(user, 'last_name', 'User'),
            'customer_email': safe_get(user, 'email', 'not-provided@example.com'),
            'customer_phone': safe_get(user, 'phone', 'Not provided'),
            'customer_address': safe_get(user, 'profile.address', 'Address not provided'),
            'customer_city': safe_get(user, 'profile.city', 'City not provided'),
            'customer_country': safe_get(user, 'profile.country', 'Country not provided'),
            'flight_details': flight_details,
            'booking_status': 'Confirmed',
            'confirmation_code': ref_no,
            'user': user,
            # Additional safe fields
            'company_name': 'Beyond Clinic',
            'company_address': '123 Medical Street, Health City',
            'company_phone': '+1-555-BEYOND',
            'company_email': 'info@beyondclinic.com',
            'payment_method': safe_get(request.POST, 'payment_method', 'Credit Card'),
            'total_amount': safe_get(flight_details, 'price', '0.00'),
            'currency': safe_get(flight_details, 'currency', 'USD'),
            'booking_date': datetime.now().strftime('%B %d, %Y'),
            'departure_airport': safe_get(request.POST, 'departure', 'ALG'),
            'arrival_airport': safe_get(request.POST, 'arrival', 'FRA'),
            'departure_date': safe_get(request.POST, 'departure_date', 'Not specified'),
            'return_date': safe_get(request.POST, 'return_date', 'Not specified'),
            'passengers': safe_get(request.POST, 'passengers', '1'),
        }
        
        print(f"=== PDF GENERATION USING XHTML2PDF ===")
        print(f"User: {user.email}")
        print(f"Reference: {ref_no}")
        print(f"Invoice: {invoice_data['invoice_number']}")
        
        # Check if user wants PDF download (via URL parameter)
        if request.GET.get('format') == 'pdf':
            try:
                # Try our improved PDF generation first
                pdf_response = simple_render_to_pdf('demo/flight_invoice_pdf.html', invoice_data)
                if not pdf_response:
                    # Fallback to original method
                    pdf_response = render_to_pdf('demo/flight_invoice_pdf.html', invoice_data)
                
                if pdf_response:
                    pdf_response['Content-Disposition'] = f'attachment; filename="flight_invoice_{ref_no}.pdf"'
                    return pdf_response
                else:
                    print("Both PDF generation methods failed")
                    # Fallback if PDF generation fails
                    return render(request, "demo/flight_invoice.html", {
                        'invoice': invoice_data,
                        'error': True,
                        'message': 'PDF generation failed, showing web version.'
                    })
            except Exception as pdf_error:
                print(f"PDF generation error: {pdf_error}")
                return render(request, "demo/flight_invoice.html", {
                    'invoice': invoice_data,
                    'error': True,
                    'message': f'PDF generation failed: {str(pdf_error)}. Showing web version.'
                })
        
        # Show the beautiful web invoice with PDF download option
        return render(request, "demo/flight_invoice.html", {
            'invoice': invoice_data,
            'success': True,
            'message': f'Booking confirmed for {user.first_name}! Here is your beautiful invoice.',
            'show_pdf_download': True,
            'pdf_url': f"/book_flight_enhanced/{flight}/?format=pdf"
        })
        
    except Exception as error:
        print(f"Direct booking error: {error}")
        return render(request, "demo/flight_invoice.html", {
            'error': True,
            'message': f'There was an error processing your booking: {str(error)}'
        })
def book_flight(request, flight):
    # Create a fake traveler profile for booking
    traveler = {
        "id": "1",
        "dateOfBirth": "1982-01-16",
        "name": {"firstName": "JORGE", "lastName": "GONZALES"},
        "gender": "MALE",
        "contact": {
            "emailAddress": "jorge.gonzales833@telefonica.es",
            "phones": [
                {
                    "deviceType": "MOBILE",
                    "countryCallingCode": "34",
                    "number": "480080076",
                }
            ],
        },
        "documents": [
            { 
                "documentType": "PASSPORT",
                "birthPlace": "Madrid",
                "issuanceLocation": "Madrid",
                "issuanceDate": "2015-04-14",
                "number": "00000000",
                "expiryDate": "2025-04-14",
                "issuanceCountry": "ES",
                "validityCountry": "ES",
                "nationality": "ES",
                "holder": True,
            }
        ],
    }
    # Use Flight Offers Price to confirm price and availability
    try:
        flight_price_confirmed = amadeus.shopping.flight_offers.pricing.post(
            ast.literal_eval(flight)
        ).data["flightOffers"]
    except (ResponseError, KeyError, AttributeError) as error:
        messages.add_message(request, messages.ERROR, error.response.body)
        return render(request, "demo/book_flight.html", {})

    # Use Flight Create Orders to perform the booking
    try:
        order = amadeus.booking.flight_orders.post(
            flight_price_confirmed, traveler
        ).data
    except (ResponseError, KeyError, AttributeError) as error:
        messages.add_message(
            request, messages.ERROR, error.response.result["errors"][0]["detail"]
        )
        return render(request, "demo/book_flight.html", {})

    passenger_name_record = []
    booking = Booking(order).construct_booking()
    passenger_name_record.append(booking)

    return render(request, "demo/book_flight.html", {"response": passenger_name_record})

def origin_airport_search(request):
    term = request.GET.get("term", "").lower()
    if request.headers.get('x-requested-with') == 'XMLHttpRequest':
        matching_airports = [airport for code, airport in airports.items() if term in code.lower()]
        if not matching_airports:
            matching_airports = [airport for code, airport in airports.items() if term in airport["city"].lower()]
        if not matching_airports:
            matching_airports = [airport for code, airport in airports.items() if term in airport["name"].lower()]
        return JsonResponse(get_city_airport_list(matching_airports), safe=False)
    return JsonResponse({"error": "Invalid request"}, status=400)

def destination_airport_search(request):
    term = request.GET.get("term", "").lower()
    if request.headers.get('x-requested-with') == 'XMLHttpRequest':
        matching_airports = [airport for code, airport in airports.items() if term in code.lower()]
        if not matching_airports:
            matching_airports = [airport for code, airport in airports.items() if term in airport["city"].lower()]
        if not matching_airports:
            matching_airports = [airport for code, airport in airports.items() if term in airport["name"].lower()]
        return JsonResponse(get_city_airport_list(matching_airports), safe=False)
    return JsonResponse({"error": "Invalid request"}, status=400)

def get_city_airport_list(data):
    result = []
    for airport in data:
        result.append(f'{airport["iata"]}, {airport["name"]}')
    return result

@login_required
def upload_id_and_save(request):
    print("[DEBUG] Entered upload_id_and_save view")
    
    if request.method == "POST":
        print("[DEBUG] Request method is POST")
        
        user = request.user
        print(f"[DEBUG] Logged in user: {user.username}")
        
        uploaded_file = request.FILES.get('id_image')
        print(f"[DEBUG] Uploaded file: {uploaded_file}")
        
        if not uploaded_file:
            print("[DEBUG] No file uploaded, returning error response")
            return JsonResponse({"error": "No file uploaded"}, status=400)

        try:
            # Save the file to the MedicalFile model
            medical_file = MedicalFile.objects.create(
                user=user,
                file=uploaded_file
            )
            print(f"[DEBUG] Medical file saved: {medical_file}")

            return JsonResponse({"message": "File uploaded successfully", "file_path": medical_file.file.name}, status=200)
        except Exception as e:
            print(f"[DEBUG] Error during file upload: {e}")
            return JsonResponse({"error": str(e)}, status=500)
    
    print("[DEBUG] Request method is not POST, returning error response")
    return JsonResponse({"error": "Invalid request"}, status=400)


def ocr_uploaded_document(request):
    if request.method == "POST":
        file_path = request.POST.get("file_path")
        try:
            image = Image.open(file_path)
            # Note: pytesseract is not currently imported/configured
            # text = pytesseract.image_to_string(image)
            text = "OCR functionality temporarily disabled"
            print("Extracted text: {}".format(text))
            # Process the extracted text as needed
            return JsonResponse({"extracted_text": text}, status=200)
        except Exception as e:
            print("Error during OCR: {}".format(e))
            return JsonResponse({"error": str(e)}, status=500)
    return JsonResponse({"error": "Invalid request"}, status=400)

@login_required
def generate_referral_code_view(request):
    user = request.user
    if not user.referral_code:
        user.referral_code = get_or_create_referral_code()
        user.save()
    return JsonResponse({'referral_code': user.referral_code})


def reverse_geocode(request):
    latitude = request.GET.get('latitude')
    longitude = request.GET.get('longitude')
    
    if latitude and longitude:
        try:
            # Initialize the Nominatim geocoder
            geolocator = Nominatim(user_agent="geo_extractor")
            
            # Reverse geocoding
            location = geolocator.reverse((latitude, longitude), exactly_one=True)
            
            if location:
                address = location.raw['address']
                
                # Extracting details
                city = address.get('city', '') or address.get('town', '') or address.get('village', '')
                town = address.get('town', '')
                province = address.get('province', '')
                country = address.get('country', '')

                return JsonResponse({
                    'city': city,
                    'town': town,
                    'province': province,
                    'country': country
                }, status=200)
            else:
                return JsonResponse({'error': 'Location not found'}, status=404)
        except Exception as e:
            return JsonResponse({'error': str(e)}, status=500)
    else:
        return JsonResponse({'error': 'Invalid coordinates'}, status=400)
    

def find_nearest_airport(city_name):
    city_name = city_name.lower()
    nearest_airport = None
    
    # Simple search for the airport in the airports dataset by city name
    for code, data in airports.items():
        if city_name in data['city'].lower():
            nearest_airport = data['iata']
            break
    
    if not nearest_airport:
        return 'No nearby airport found'
    
    return nearest_airport

def check_email(request):
    return render(request, 'check_email.html')

def privacypolicy(request):
    return render(request, 'privacypolicy.html')

def TermsofService(request):
    return render(request, 'TermsofService.html')

def streamlit_embed(request):
    return render(request, 'chat.html')

def microsofter(request):
    return render(request, 'microsofter.html')


def user_list_view(request):
    # Order by is_online (True first), then by last_login_time (most recent first)
    users = User.objects.all().order_by('-is_online', '-last_login_time')
    return render(request, 'user_table.html', {'users': users})

@login_required
@user_passes_test(checks.admin_check)
def logs(request):
    User = get_user_model()
    
    users = User.objects.all().order_by('-is_online', '-last_login_time')
    
    group_count = MessageGroup.objects.count()
    average_count = 0
    message_count = Message.objects.count()
    hospital = request.user.hospital()
    if group_count > 0 and message_count > 0:
        average_count = float(message_count) / float(group_count)
    stays = HospitalStay.objects.filter(discharge__isnull=False)
    average_stay = 0.0
    if stays:
        for stay in stays:
            average_stay += float((stay.discharge - stay.admission).total_seconds())
        average_stay /= len(stays)
    average_stay_formatted = time.strftime('%H:%M:%S', time.gmtime(average_stay))
    
    context = {
        "navbar": "logs",
        "user": request.user,
        "logs": LogEntry.objects.all().order_by('-action_time'),
        "users": users,  # Ensure users is passed here
        "stats": {
            "user_count": HospitalStay.objects.filter(hospital=hospital, discharge__isnull=True).count(),
            "stay_count": HospitalStay.objects.filter(hospital=hospital).count(),
            "discharge_count": HospitalStay.objects.filter(hospital=hospital, discharge__isnull=False).count(),
            "average_stay": average_stay_formatted,
            "patient_count": HospitalStay.objects.filter(hospital=hospital, patient__groups__name='Patient').distinct().count(),
            "doctor_count": HospitalStay.objects.filter(hospital=hospital, patient__groups__name='Doctor').distinct().count(),
            "nurse_count": HospitalStay.objects.filter(hospital=hospital, patient__groups__name='Nurse').distinct().count(),
            "admin_count": User.objects.filter(is_superuser=True).count(),
            "prescription_count": Prescription.objects.count(),
            "active_prescription_count": Prescription.objects.filter(active=True).count(),
            "expired_prescription_count": Prescription.objects.filter(active=False).count(),
            "appointment_count": Appointment.objects.count(),
            "upcoming_appointment_count": Appointment.objects.filter(date__gte=timezone.now()).count(),
            "past_appointment_count": Appointment.objects.filter(date__lt=timezone.now()).count(),
            "conversation_count": group_count,
            "average_message_count": average_count,
            "message_count": message_count
        }
    }
    return render(request, 'logs.html', context)



def static_appointments_chart(request):
    # Get appointment data
    appointments = TreatmentPlan.objects.all()

    # Prepare data for the chart
    doctor_names = [plan.doctor.get_full_name() for plan in appointments]

    # Create a simple bar chart with Plotly
    fig = px.histogram(doctor_names, x=doctor_names, title="Appointments Per Doctor")
    
    # Convert Plotly chart to HTML
    chart = fig.to_html(full_html=False)

    # Pass the chart to the template context
    context = {
        'chart': chart,
    }

    return render(request, 'static_appointments_chart.html', context)


@login_required
@csrf_exempt
def update_profile_picture(request):
    """
    Handle profile picture upload via AJAX with automatic resizing
    """
    if request.method == 'POST':
        try:
            # Get the uploaded file
            profile_picture = request.FILES.get('profile_picture')
            
            if not profile_picture:
                return JsonResponse({
                    'success': False,
                    'error': _('No image file provided.')
                })
            
            # Validate file type
            allowed_types = ['image/jpeg', 'image/jpg', 'image/png', 'image/gif']
            if profile_picture.content_type not in allowed_types:
                return JsonResponse({
                    'success': False,
                    'error': _('Invalid file type. Please upload a JPEG, PNG, or GIF image.')
                })
            
            # Validate file size (max 5MB)
            max_size = 5 * 1024 * 1024  # 5MB
            if profile_picture.size > max_size:
                return JsonResponse({
                    'success': False,
                    'error': _('File size too large. Please upload an image smaller than 5MB.')
                })
            
            # Process and resize the image
            try:
                processed_file = resize_profile_image(profile_picture)
            except Exception as e:
                logging.error(f"Error processing image: {e}")
                return JsonResponse({
                    'success': False,
                    'error': _('Error processing image. Please try with a different image.')
                })
            
            # Get the user
            user = request.user
            
            # Delete old profile picture if it exists
            if hasattr(user, 'thumbnail') and user.thumbnail and user.thumbnail.file:
                try:
                    if default_storage.exists(user.thumbnail.file.name):
                        default_storage.delete(user.thumbnail.file.name)
                except Exception as e:
                    # Log but don't fail the upload if old file deletion fails
                    logging.warning(f"Failed to delete old profile picture: {e}")
            
            # Save the new resized profile picture
            if hasattr(user, 'thumbnail'):
                user.thumbnail.file = processed_file
                user.thumbnail.save()
                user.save()
            else:
                # If using a separate UserProfile model, adjust accordingly
                # user.userprofile.profile_picture = processed_file
                # user.userprofile.save()
                logging.warning("User model does not have thumbnail field")
                return JsonResponse({
                    'success': False,
                    'error': _('User profile structure not configured for image uploads.')
                })
            
            return JsonResponse({
                'success': True,
                'message': _('Profile picture updated successfully!'),
                'image_url': user.thumbnail.file.url if hasattr(user, 'thumbnail') and user.thumbnail and user.thumbnail.file else None
            })
            
        except Exception as e:
            logging.error(f"Error updating profile picture: {e}")
            return JsonResponse({
                'success': False,
                'error': _('An error occurred while updating your profile picture. Please try again.')
            })
    
    return JsonResponse({
        'success': False,
        'error': _('Invalid request method.')
    })


