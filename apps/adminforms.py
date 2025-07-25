from django import forms
from django.contrib.auth import get_user_model
from .models import Insurance, EmergencyContact, MedicalInformation, Hospital, Appointment, HospitalStay, Prescription, MessageGroup, Message, Subscription, Contact, EmailTemplate

User = get_user_model()

# Form for the User model
class UserAdminForm(forms.ModelForm):
    class Meta:
        model = User
        fields = ['first_name', 'last_name', 'email', 'phone_number', 'date_of_birth', 'medical_information', 'emergency_contact', 'thumbnail', 'is_active', 'groups', 'user_permissions']
        widgets = {
            'groups': forms.CheckboxSelectMultiple(),
            'user_permissions': forms.CheckboxSelectMultiple(),
        }

# Form for the Insurance model
class InsuranceAdminForm(forms.ModelForm):
    class Meta:
        model = Insurance
        fields = ['policy_number', 'company']

# Form for the EmergencyContact model
class EmergencyContactAdminForm(forms.ModelForm):
    class Meta:
        model = EmergencyContact
        fields = ['first_name', 'last_name', 'phone_number', 'relationship']

# Form for the MedicalInformation model
class MedicalInformationAdminForm(forms.ModelForm):
    class Meta:
        model = MedicalInformation
        fields = ['sex', 'insurance', 'medications', 'allergies', 'medical_conditions', 'family_history', 'additional_info']

# Form for the Hospital model
class HospitalAdminForm(forms.ModelForm):
    class Meta:
        model = Hospital
        fields = ['name', 'address', 'city', 'state', 'zipcode']

# Form for the Appointment model
class AppointmentAdminForm(forms.ModelForm):
    class Meta:
        model = Appointment
        fields = ['patient', 'doctor', 'date', 'duration']

# Form for the HospitalStay model
class HospitalStayAdminForm(forms.ModelForm):
    class Meta:
        model = HospitalStay
        fields = ['patient', 'admission', 'discharge', 'hospital']

# Form for the Prescription model
class PrescriptionAdminForm(forms.ModelForm):
    class Meta:
        model = Prescription
        fields = ['patient', 'name', 'dosage', 'directions', 'prescribed', 'active']

# Form for the MessageGroup model
class MessageGroupAdminForm(forms.ModelForm):
    class Meta:
        model = MessageGroup
        fields = ['name', 'members']
        widgets = {
            'members': forms.CheckboxSelectMultiple(),
        }

# Form for the Message model
class MessageAdminForm(forms.ModelForm):
    class Meta:
        model = Message
        fields = ['sender', 'group', 'body', 'date', 'read_members']
        widgets = {
            'read_members': forms.CheckboxSelectMultiple(),
        }

# Form for the Subscription model
class SubscriptionAdminForm(forms.ModelForm):
    class Meta:
        model = Subscription
        fields = ['email']

# Form for the Contact model
class ContactAdminForm(forms.ModelForm):
    class Meta:
        model = Contact
        fields = ['first_name', 'last_name', 'email', 'message']

# Form for the EmailTemplate model
class EmailTemplateAdminForm(forms.ModelForm):
    class Meta:
        model = EmailTemplate
        fields = ['name', 'subject', 'body']
