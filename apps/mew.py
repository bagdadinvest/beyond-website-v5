from django.conf import settings
import os
from django.contrib.auth import get_user_model
from django.shortcuts import render, get_object_or_404, redirect
from django.contrib.auth.decorators import login_required, user_passes_test
from django.http import HttpResponse, JsonResponse
from django.utils.translation import gettext_lazy as _  # For translations

from django.contrib.auth.models import Group
from django import forms
from django.forms import formset_factory, inlineformset_factory
from django.contrib import messages
from django.views.generic import DetailView
from django.contrib.auth.mixins import UserPassesTestMixin
from actstream import action
from django.template.loader import get_template
from weasyprint import HTML
from django.core.exceptions import ObjectDoesNotExist

from .models import User, MedicalFile, Hospital, MedicalInformation, TreatmentPlan, TreatmentPlanItem, EmergencyContact, TreatmentProduct
from .forms import TreatmentPlanForm, TreatmentProductForm, TreatmentPlanItemFormSet

User = get_user_model()

def staff_required(user):
    print(f"Checking if user {user} is staff")
    return user.is_staff

# Define a form for TreatmentPlanItem
class TreatmentPlanItemForm(forms.ModelForm):
    class Meta:
        model = TreatmentPlanItem
        fields = ['product', 'quantity']

# Patient Listing View
@login_required
@user_passes_test(staff_required)
def list_patients(request):
    print("Entering list_patients view")
    sort_by = request.GET.get('sort_by', 'date_joined')
    sort_order = request.GET.get('sort_order', 'asc')
    print(f"Sorting patients by {sort_by} in {sort_order} order")

    if sort_order == 'desc':
        sort_by = '-' + sort_by

    patients = User.objects.filter(groups__name='Patient').order_by(sort_by)
    print(f"Found {patients.count()} patients")

    patient_list = []
    for patient in patients:
        has_medical_files = MedicalFile.objects.filter(user=patient).exists()
        hospital_name = Hospital.objects.filter(hospitalstay__patient=patient).values_list('name', flat=True).first()
        medical_info = MedicalInformation.objects.filter(user=patient).first()

        patient_list.append({
            'name': f"{patient.first_name} {patient.last_name}",
            'thumbnail': patient.thumbnail.url if patient.thumbnail else '/media/profile_pictures/Profile-PNG-Photo.png',
            'user_id': patient.id,
            'nationality': patient.nationality,
            'hospital': hospital_name or _('N/A'),
            'date_of_birth': patient.date_of_birth,
            'sex': medical_info.sex if medical_info else _('N/A'),
            'has_medical_files': has_medical_files,
        })

    context = {
        'patients': patient_list,
        'sort_by': sort_by,
        'sort_order': sort_order,
    }

    print("Rendering list_npatients.html with context", context)
    return render(request, 'list_npatients.html', context)

# Dashboard View
@login_required
@user_passes_test(staff_required)
def ndashboard_view(request):
    print("Entering ndashboard_view")
    patient_group = Group.objects.get(name='Patient')

    active_users_count = User.objects.filter(groups=patient_group, is_active=True).count()
    total_appointments = TreatmentPlan.objects.count()
    total_purchases = TreatmentPlanItem.objects.count()

    print(f"Active users: {active_users_count}, Appointments: {total_appointments}, Purchases: {total_purchases}")

    positive_reviews_percentage = 80
    neutral_reviews_percentage = 17
    negative_reviews_percentage = 3

    context = {
        'active_users_count': active_users_count,
        'total_appointments': total_appointments,
        'total_purchases': total_purchases,
        'positive_reviews_percentage': positive_reviews_percentage,
        'neutral_reviews_percentage': neutral_reviews_percentage,
        'negative_reviews_percentage': negative_reviews_percentage,
    }

    print("Rendering ndash.html with context", context)
    return render(request, 'ndash.html', context)

@login_required
@user_passes_test(staff_required)
def patient_detail(request, patient_id):
    print(f"Entering patient_detail view for patient_id: {patient_id}")
    patient = get_object_or_404(User, id=patient_id, groups__name='Patient')
    
    # Fetch related data
    has_medical_files = MedicalFile.objects.filter(user=patient).exists()
    hospital_name = Hospital.objects.filter(hospitalstay__patient=patient).values_list('name', flat=True).first()

    try:
        medical_info = MedicalInformation.objects.get(user=patient)
    except MedicalInformation.DoesNotExist:
        medical_info = None

    emergency_contact = patient.emergency_contact
    medical_files = MedicalFile.objects.filter(user=patient).order_by('-upload_timestamp')
    treatment_plans = TreatmentPlan.objects.filter(patient=patient).order_by('-created_at')

    print(f"Found medical_info: {medical_info}, emergency_contact: {emergency_contact}, treatment_plans: {treatment_plans.count()}")

    # Create formsets for treatment plans
    from .forms import TreatmentPlanForm, TreatmentPlanItemFormSet
    
    if request.method == 'POST':
        print("Handling POST request to save treatment plan")
        treatment_plan_id = request.POST.get('treatment_plan_id')
        
        if treatment_plan_id:
            # Edit existing treatment plan
            treatment_plan = get_object_or_404(TreatmentPlan, id=treatment_plan_id, patient=patient)
            action_verb = _("edited")
        else:
            # Create new treatment plan
            treatment_plan = TreatmentPlan(patient=patient, doctor=request.user)
            action_verb = _("created")

        treatment_plan_form = TreatmentPlanForm(request.POST, instance=treatment_plan)
        treatment_plan_item_formset = TreatmentPlanItemFormSet(request.POST, instance=treatment_plan)

        if treatment_plan_form.is_valid() and treatment_plan_item_formset.is_valid():
            print("Treatment plan form and item formset are valid")
            
            # Save treatment plan
            treatment_plan = treatment_plan_form.save(commit=False)
            treatment_plan.patient = patient
            treatment_plan.doctor = request.user
            treatment_plan.save()

            # Save treatment plan items
            treatment_plan_item_formset.instance = treatment_plan
            items = treatment_plan_item_formset.save()

            # Recalculate totals
            treatment_plan.save()  # This will trigger the calculate methods in the model

            action.send(
                request.user,
                verb=f"{action_verb} {_('a treatment plan for')} {patient.get_full_name()}",
                target=treatment_plan
            )

            messages.success(request, _("Treatment plan saved successfully."))
            return redirect('app:patient_detail', patient_id=patient.id)
        else:
            print("Errors in form submission")
            print("Form errors:", treatment_plan_form.errors)
            print("Formset errors:", treatment_plan_item_formset.errors)
            messages.error(request, _("There were errors in the form submission. Please correct them and try again."))
    else:
        print("Handling GET request to render treatment plan form")
        treatment_plan_form = TreatmentPlanForm()
        treatment_plan_item_formset = TreatmentPlanItemFormSet()

    # Prepare context data
    context = {
        'patient': {
            'first_name': patient.first_name,
            'last_name': patient.last_name,
            'thumbnail': patient.thumbnail.url if patient.thumbnail else '/media/profile_pictures/Profile-PNG-Photo.png',
            'user_id': patient.id,
            'nationality': patient.nationality,
            'hospital': hospital_name or _('N/A'),
            'date_of_birth': patient.date_of_birth,
            'sex': medical_info.sex if medical_info else _('N/A'),
            'insurance': medical_info.insurance if medical_info else _('N/A'),
            'medications': medical_info.medications if medical_info else _('N/A'),
            'allergies': medical_info.allergies if medical_info else _('N/A'),
            'medical_conditions': medical_info.medical_conditions if medical_info else _('N/A'),
            'family_history': medical_info.family_history if medical_info else _('N/A'),
            'additional_info': medical_info.additional_info if medical_info else _('N/A'),
            'has_medical_files': has_medical_files,
            'emergency_contact': emergency_contact,
            'medical_files': medical_files,
            'treatment_plans': treatment_plans,
            'email': patient.email,
            'phone_number': patient.phone_number,
        },
        'treatment_plan_form': treatment_plan_form,
        'treatment_plan_item_formset': treatment_plan_item_formset,
        'available_products': TreatmentProduct.objects.filter(is_active=True),
    }

    print("Rendering patient_detail.html with context")
    return render(request, 'patient_detail.html', context)

@login_required
@user_passes_test(staff_required)
def delete_treatment_plan(request, pk):
    """Delete a treatment plan"""
    treatment_plan = get_object_or_404(TreatmentPlan, pk=pk)
    patient_id = treatment_plan.patient.id
    
    if request.method == 'DELETE':
        treatment_plan.delete()
        action.send(request.user, verb=_("deleted a treatment plan"), target=treatment_plan.patient)
        return JsonResponse({'success': True})
    
    return JsonResponse({'success': False, 'error': 'Invalid method'})

@login_required
@user_passes_test(staff_required)
def treatment_plan_api(request, pk):
    """API endpoint for treatment plan data"""
    treatment_plan = get_object_or_404(TreatmentPlan, pk=pk)
    
    data = {
        'id': treatment_plan.id,
        'final_discount_percentage': str(treatment_plan.final_discount_percentage),
        'subtotal': str(treatment_plan.subtotal or 0),
        'discount_amount': str(treatment_plan.discount_amount or 0),
        'total_price': str(treatment_plan.total_price or 0),
        'items': []
    }
    
    for item in treatment_plan.treatmentplanitem_set.all():
        data['items'].append({
            'product': item.product.id,
            'product_name': item.product.name,
            'quantity': item.quantity,
            'discount_percentage': str(item.discount_percentage),
            'item_total': str(item.item_total())
        })
    
    return JsonResponse(data)


@login_required
def my_treatment_plans(request):
    print("Entering my_treatment_plans view for user", request.user)
    # Fetch the treatment plans associated with the logged-in user (patient)
    treatment_plans = TreatmentPlan.objects.filter(patient=request.user)

    # If the user has no treatment plans, redirect to medical information page
    if not treatment_plans.exists():
        messages.info(request, _('You have no treatment plans. Redirecting to medical information...'))
        return redirect('app:my_medical_information')

    # Log the action of viewing treatment plans
    action.send(request.user, verb=_("viewed their treatment plans"), target=request.user)

    context = {
        'treatment_plans': treatment_plans,
    }
    print("Rendering my_treatment_plans.html with context", context)
    return render(request, 'my_treatment_plans.html', context)


# Treatment Product Views
@login_required
@user_passes_test(lambda u: u.is_staff)
def create_treatment_product(request):
    print("Entering create_treatment_product view")
    if request.method == 'POST':
        form = TreatmentProductForm(request.POST, request.FILES)
        if form.is_valid():
            print("Form is valid, saving treatment product")
            form.save()
            action.send(request.user, verb=_("created a new treatment product"), target=form.instance)
            return redirect('app:treatment_product_list')
        else:
            print("Form is invalid, errors:", form.errors)
    else:
        form = TreatmentProductForm()

    print("Rendering treatment_product_form.html")
    return render(request, 'treatment_product_form.html', {'form': form})

@login_required
def download_treatment_plan_pdf(request):
    print("Entering download_treatment_plan_pdf view for user", request.user)
    # Get the user's treatment plans
    treatment_plans = TreatmentPlan.objects.filter(patient=request.user)

    # Render the HTML template with the context
    template = get_template('my_treatment_plans_pdf.html')
    html_content = template.render({'treatment_plans': treatment_plans, 'user': request.user})

    # Load the CSS file
    css_path = os.path.join(settings.STATIC_ROOT, 'assets/css/argon-dashboard.css')

    # Create a response object
    response = HttpResponse(content_type='application/pdf')
    response['Content-Disposition'] = f'attachment; filename="treatment_plans_{request.user.username}.pdf"'

    # Generate the PDF using WeasyPrint
    print("Generating PDF using WeasyPrint")
    HTML(string=html_content).write_pdf(response, stylesheets=[css_path])

    return response

@login_required
@user_passes_test(lambda u: u.is_staff)
def treatment_product_list(request):
    print("Entering treatment_product_list view")
    products = TreatmentProduct.objects.all()
    print(f"Found {products.count()} treatment products")
    return render(request, 'treatment_product_list.html', {'products': products})

# Treatment Plan Management Views
class TreatmentPlanDetailView(UserPassesTestMixin, DetailView):
    model = TreatmentPlan
    template_name = 'treatment_plan_detail.html'
    context_object_name = 'treatment_plan'

    def test_func(self):
        print("Checking if user is staff for treatment plan detail view")
        return self.request.user.is_staff

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        action.send(self.request.user, verb=_("viewed treatment plan"), target=self.get_object())
        print("Rendering treatment_plan_detail.html with context", context)
        return context

@login_required
@user_passes_test(staff_required)
def create_treatment_plan(request, patient_id):
    print(f"Entering create_treatment_plan view for patient_id: {patient_id}")
    patient = get_object_or_404(User, pk=patient_id)
    TreatmentPlanItemFormSet = inlineformset_factory(
        TreatmentPlan, TreatmentPlanItem, form=TreatmentPlanItemForm, extra=1, can_delete=True
    )

    if request.method == 'POST':
        form = TreatmentPlanForm(request.POST)
        formset = TreatmentPlanItemFormSet(request.POST)

        if form.is_valid() and formset.is_valid():
            print("Form and formset are valid, creating new treatment plan")
            treatment_plan = form.save(commit=False)
            treatment_plan.patient = patient
            treatment_plan.doctor = request.user
            treatment_plan.save()

            formset.instance = treatment_plan
            formset.save()

            treatment_plan.calculate_total_price()
            treatment_plan.save()

            action.send(request.user, verb=_("created a new treatment plan"), target=treatment_plan)
            return redirect('app:patient_detail', patient_id=patient.id)
        else:
            print("Form or formset has errors")
    else:
        form = TreatmentPlanForm()
        formset = TreatmentPlanItemFormSet()

    print("Rendering treatment_plan_form.html")
    return render(request, 'treatment_plan_form.html', {
        'form': form,
        'formset': formset,
        'patient': patient
    })


@login_required
@user_passes_test(staff_required)
def edit_treatment_plan(request, pk):
    print(f"Entering edit_treatment_plan view for treatment_plan id: {pk}")
    treatment_plan = get_object_or_404(TreatmentPlan, pk=pk)
    TreatmentPlanItemFormSet = inlineformset_factory(
        TreatmentPlan, TreatmentPlanItem, form=TreatmentPlanItemForm, extra=1, can_delete=True
    )

    if request.method == 'POST':
        form = TreatmentPlanForm(request.POST, instance=treatment_plan)
        formset = TreatmentPlanItemFormSet(request.POST, instance=treatment_plan)

        if form.is_valid() and formset.is_valid():
            print("Form and formset are valid, updating treatment plan")
            form.save()
            formset.save()

            treatment_plan.calculate_total_price()
            treatment_plan.save()

            action.send(request.user, verb=_("edited a treatment plan"), target=treatment_plan)
            return redirect('app:patient_detail', patient_id=treatment_plan.patient.id)
        else:
            print("Form or formset has errors")
    else:
        form = TreatmentPlanForm(instance=treatment_plan)
        formset = TreatmentPlanItemFormSet(instance=treatment_plan)

    print("Rendering treatment_plan_form.html")
    return render(request, 'treatment_plan_form.html', {
        'form': form,
        'formset': formset,
        'patient': treatment_plan.patient
    })

@login_required
@user_passes_test(lambda u: u.is_staff)
def patient_appointment_dashboard_view(request):
    print("Entering patient_appointment_dashboard_view")
    return render(request, 'patient_appointment_dashboard.html')
