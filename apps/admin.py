from django.contrib import admin
from django.core.mail import send_mail
from django.template.loader import render_to_string
from django.utils.html import strip_tags, format_html
from django.utils.translation import gettext_lazy as _
from django.conf import settings
from import_export import resources
from import_export.admin import ImportExportModelAdmin
from allauth.account.models import EmailAddress
from allauth.account.admin import EmailAddressAdmin as AllauthEmailAddressAdmin
from .models import (
    User, Appointment, Prescription, Insurance, EmergencyContact,
    Hospital, Subscription, Contact, Referral, MedicalInformation,
    HospitalStay, MessageGroup, Message, EmailTemplate, TreatmentProduct,
    TreatmentPlan, TreatmentPlanItem, Accommodation, Hotel, FlightReservation, PatientSchedule
)


# Email actions
@admin.action(description='Send verification email')
def send_verification_email(modeladmin, request, queryset):
    for email_address in queryset:
        if not email_address.verified:
            subject = 'Verify Your Email Address'
            html_message = render_to_string('emails/verification_email.html', {'user': email_address.user})
            plain_message = strip_tags(html_message)
            from_email = settings.DEFAULT_FROM_EMAIL
            send_mail(subject, plain_message, from_email, [email_address.email], html_message=html_message)
            modeladmin.message_user(request, f'Verification email sent to {email_address.email}')

@admin.action(description='Send password reset email')
def send_password_reset_email(modeladmin, request, queryset):
    for user in queryset:
        subject = 'Password Reset Request'
        reset_url = request.build_absolute_uri(f'/reset/{user.pk}/{user.password_reset_token}/')
        html_message = render_to_string('registration/password_reset_email.html', {'user': user, 'reset_url': reset_url})
        plain_message = strip_tags(html_message)
        from_email = settings.DEFAULT_FROM_EMAIL
        send_mail(subject, plain_message, from_email, [user.email], html_message=html_message)

# Resources for import-export functionality
class UserResource(resources.ModelResource):
    class Meta:
        model = User

class AppointmentResource(resources.ModelResource):
    class Meta:
        model = Appointment

class PrescriptionResource(resources.ModelResource):
    class Meta:
        model = Prescription

class InsuranceResource(resources.ModelResource):
    class Meta:
        model = Insurance

class EmergencyContactResource(resources.ModelResource):
    class Meta:
        model = EmergencyContact

class HospitalResource(resources.ModelResource):
    class Meta:
        model = Hospital

class SubscriptionResource(resources.ModelResource):
    class Meta:
        model = Subscription

class ContactResource(resources.ModelResource):
    class Meta:
        model = Contact

class ReferralResource(resources.ModelResource):
    class Meta:
        model = Referral

class MedicalInformationResource(resources.ModelResource):
    class Meta:
        model = MedicalInformation

class HospitalStayResource(resources.ModelResource):
    class Meta:
        model = HospitalStay

class MessageGroupResource(resources.ModelResource):
    class Meta:
        model = MessageGroup

class MessageResource(resources.ModelResource):
    class Meta:
        model = Message

class EmailTemplateResource(resources.ModelResource):
    class Meta:
        model = EmailTemplate

class TreatmentProductResource(resources.ModelResource):
    class Meta:
        model = TreatmentProduct

class TreatmentPlanResource(resources.ModelResource):
    class Meta:
        model = TreatmentPlan

class TreatmentPlanItemResource(resources.ModelResource):
    class Meta:
        model = TreatmentPlanItem

class HotelResource(resources.ModelResource):
    class Meta:
        model = Hotel

@admin.register(Hotel)
class HotelAdmin(ImportExportModelAdmin):
    resource_class = HotelResource
    list_display = ('name', 'address', 'price_per_night', 'room_type', 'amenities')
    search_fields = ('name', 'address', 'room_type')
    list_filter = ('room_type',)

# Admin classes
class UserAdmin(ImportExportModelAdmin):
    resource_class = UserResource
    list_display = ('username', 'email', 'date_of_birth', 'phone_number', 'emergency_contact', 'thumbnail', 'referral_code', 'referred_by', 'thread_id', 'beyondblog_profileid')
    search_fields = ('username', 'email', 'phone_number')
    list_filter = ('date_of_birth',)
    actions = [send_verification_email, send_password_reset_email]

class AppointmentAdmin(ImportExportModelAdmin):
    resource_class = AppointmentResource
    list_display = ('patient', 'doctor', 'date', 'duration')
    search_fields = ('patient__username', 'doctor__username')
    list_filter = ('date',)

class PrescriptionAdmin(ImportExportModelAdmin):
    resource_class = PrescriptionResource
    list_display = ('patient', 'name', 'dosage', 'prescribed', 'active')
    search_fields = ('patient__username', 'name')
    list_filter = ('active', 'prescribed')

class InsuranceAdmin(ImportExportModelAdmin):
    resource_class = InsuranceResource
    list_display = ('policy_number', 'company')
    search_fields = ('policy_number', 'company')

class EmergencyContactAdmin(ImportExportModelAdmin):
    resource_class = EmergencyContactResource
    list_display = ('first_name', 'last_name', 'phone_number', 'relationship')
    search_fields = ('first_name', 'last_name', 'phone_number')

class HospitalAdmin(ImportExportModelAdmin):
    resource_class = HospitalResource
    list_display = ('name', 'address', 'city', 'state', 'zipcode')
    search_fields = ('name', 'city', 'state', 'zipcode')

class SubscriptionAdmin(ImportExportModelAdmin):
    resource_class = SubscriptionResource
    list_display = ('email',)
    search_fields = ('email',)

class ContactAdmin(ImportExportModelAdmin):
    resource_class = ContactResource
    list_display = ('first_name', 'last_name', 'email')
    search_fields = ('first_name', 'last_name', 'email')

class ReferralAdmin(ImportExportModelAdmin):
    resource_class = ReferralResource
    list_display = ('referrer', 'referred', 'code', 'created_at')
    search_fields = ('referrer__username', 'referred__username', 'code')
    list_filter = ('created_at',)

class MedicalInformationAdmin(ImportExportModelAdmin):
    resource_class = MedicalInformationResource
    list_display = ('sex', 'insurance', 'medications', 'allergies', 'medical_conditions')
    search_fields = ('sex', 'medications', 'allergies', 'medical_conditions')

class HospitalStayAdmin(ImportExportModelAdmin):
    resource_class = HospitalStayResource
    list_display = ('patient', 'hospital', 'admission', 'discharge')
    search_fields = ('patient__username', 'hospital__name')
    list_filter = ('admission', 'discharge')

class MessageGroupAdmin(ImportExportModelAdmin):
    resource_class = MessageGroupResource
    list_display = ('name',)
    search_fields = ('name',)

class MessageAdmin(ImportExportModelAdmin):
    resource_class = MessageResource
    list_display = ('sender', 'group', 'date')
    search_fields = ('sender__username', 'group__name')
    list_filter = ('date',)

# Resource for import/export
class AccommodationResource(resources.ModelResource):
    class Meta:
        model = Accommodation

class FlightReservationResource(resources.ModelResource):
    class Meta:
        model = FlightReservation

class PatientScheduleResource(resources.ModelResource):
    class Meta:
        model = PatientSchedule

@admin.register(EmailTemplate)
class EmailTemplateAdmin(ImportExportModelAdmin):
    resource_class = EmailTemplateResource
    list_display = ('name', 'subject')
    search_fields = ('name', 'subject')
    fields = ('name', 'subject', 'body')

class TreatmentPlanItemInline(admin.TabularInline):
    model = TreatmentPlanItem
    extra = 1

@admin.register(TreatmentPlan)
class TreatmentPlanAdmin(ImportExportModelAdmin):
    resource_class = TreatmentPlanResource
    list_display = ('patient', 'doctor', 'created_at', 'updated_at', 'final_discount_percentage', 'total_price')
    list_filter = ('created_at', 'updated_at', 'doctor')
    search_fields = ('patient__username', 'doctor__username')
    inlines = [TreatmentPlanItemInline]
    readonly_fields = ('subtotal', 'total_price')  # Show these as read-only in the admin form

    def save_model(self, request, obj, form, change):
        """Ensure the model save logic runs properly in admin."""
        obj.save()
        super().save_model(request, obj, form, change)

@admin.register(TreatmentProduct)
class TreatmentProductAdmin(ImportExportModelAdmin):
    resource_class = TreatmentProductResource
    list_display = ('name', 'category', 'price', 'country_of_origin', 'is_active', 'image_tag')
    list_filter = ('category', 'country_of_origin', 'is_active')
    search_fields = ('name', 'description')
    fieldsets = (
        (None, {
            'fields': ('name', 'slug', 'category', 'description')
        }),
        (_('Pricing & Discounts'), {
            'fields': ('price', 'max_discount_percentage')
        }),
        (_('Product Details'), {
            'fields': ('country_of_origin', 'image', 'is_active')
        }),
    )
    prepopulated_fields = {'slug': ('name',)}

    def image_tag(self, obj):
        """Show the image preview in the admin panel."""
        if obj.image:
            return format_html('<img src="{}" width="50" height="50" />'.format(obj.image.url))
        return None
    image_tag.short_description = 'Image'

@admin.register(TreatmentPlanItem)
class TreatmentPlanItemAdmin(ImportExportModelAdmin):
    resource_class = TreatmentPlanItemResource
    list_display = ('treatment_plan', 'product', 'quantity', 'discount_percentage')
    search_fields = ('treatment_plan__patient__username', 'product__name')


# Admin classes
class UserAdmin(ImportExportModelAdmin):
    resource_class = UserResource
    list_display = ('username', 'email', 'date_of_birth', 'phone_number', 'emergency_contact', 'thumbnail', 'referral_code', 'referred_by', 'thread_id', 'beyondblog_profileid')
    search_fields = ('username', 'email', 'phone_number')
    list_filter = ('date_of_birth',)
    actions = [send_verification_email, send_password_reset_email]

# Register new models in the admin
@admin.register(Accommodation)
class AccommodationAdmin(ImportExportModelAdmin):
    resource_class = AccommodationResource
    list_display = ('get_hotel_name', 'get_hotel_address', 'user', 'treatment_plan', 'duration_of_stay')
    search_fields = ('hotel__name', 'hotel__address', 'user__username')

    def get_hotel_name(self, obj):
        return obj.hotel.name if obj.hotel else None
    get_hotel_name.short_description = 'Hotel Name'

    def get_hotel_address(self, obj):
        return obj.hotel.address if obj.hotel else None
    get_hotel_address.short_description = 'Hotel Address'

@admin.register(FlightReservation)
class FlightReservationAdmin(ImportExportModelAdmin):
    resource_class = FlightReservationResource
    list_display = ('arrival_flight_number', 'arrival_date', 'departure_flight_number', 'departure_date')
    search_fields = ('arrival_flight_number', 'departure_flight_number')

@admin.register(PatientSchedule)
class PatientScheduleAdmin(ImportExportModelAdmin):
    resource_class = PatientScheduleResource
    list_display = ('user', 'appointment', 'hospital', 'accommodation', 'flight_reservation')
    search_fields = ('user__username', 'appointment__date', 'hospital__name', 'accommodation__hotel__name')
    list_filter = ('appointment__date',)



# Register all models with custom admin classes
admin.site.register(User, UserAdmin)
admin.site.register(Appointment, AppointmentAdmin)
admin.site.register(Prescription, PrescriptionAdmin)
admin.site.register(Insurance, InsuranceAdmin)
admin.site.register(EmergencyContact, EmergencyContactAdmin)
admin.site.register(Hospital, HospitalAdmin)
admin.site.register(Subscription, SubscriptionAdmin)
admin.site.register(Contact, ContactAdmin)
admin.site.register(Referral, ReferralAdmin)
admin.site.register(MedicalInformation, MedicalInformationAdmin)
admin.site.register(HospitalStay, HospitalStayAdmin)
admin.site.register(MessageGroup, MessageGroupAdmin)
admin.site.register(Message, MessageAdmin)
