print("Loading apps models...")

import os
from django.db import models
from django.contrib.auth.models import AbstractUser
from django.utils import timezone
from datetime import timedelta
from ckeditor.fields import RichTextField
from wagtail.models import Page
from wagtail.fields import RichTextField
from wagtail.admin.panels import FieldPanel
from dirtyfields import DirtyFieldsMixin
from django.utils.text import slugify
from django.core.exceptions import ValidationError
from django.core.validators import RegexValidator
from django_countries.fields import CountryField
from django.utils.translation import gettext_lazy as _  # For translations


class HomePage(Page):
    intro = RichTextField(blank=True)

    content_panels = Page.content_panels + [
        FieldPanel('intro'),
    ]

    class Meta:
        verbose_name = _("Home Page")
        verbose_name_plural = _("Home Pages")


def user_directory_path(instance, filename):
    # file will be uploaded to MEDIA_ROOT/docs/users/patient/user_id/<filename>
    return 'docs/users/patient/{0}/{1}'.format(instance.user.id, filename)


class Insurance(models.Model):
    policy_number = models.CharField(_("Policy Number"), max_length=255, null=True, blank=True)
    company = models.CharField(_("Insurance Company"), max_length=255, null=True, blank=True)

    class Meta:
        verbose_name = _("Insurance")
        verbose_name_plural = _("Insurances")

    def __repr__(self):
        return "{0} with {1}".format(self.policy_number, self.company)

    def __str__(self):
        return "{0} with {1}".format(self.policy_number, self.company)


class EmergencyContact(models.Model):
    first_name = models.CharField(_("First Name"), max_length=20)
    last_name = models.CharField(_("Last Name"), max_length=20)
    phone_number = models.CharField(_("Phone Number"), max_length=30, validators=[
        RegexValidator(regex=r'^\+?1?\d{9,15}$', message=_("Phone number must be entered in the format: '+999999999'. Up to 15 digits allowed."))
    ])
    relationship = models.CharField(_("Relationship"), max_length=30)

    class Meta:
        verbose_name = _("Emergency Contact")
        verbose_name_plural = _("Emergency Contacts")

    def json_object(self):
        return {
            'first_name': self.first_name,
            'last_name': self.last_name,
            'phone_number': self.phone_number,
            'relationship': self.relationship,
        }

    def __str__(self):
        return "{0} is {1} of him/her".format(self.first_name, self.relationship)


class MedicalInformation(DirtyFieldsMixin, models.Model):
    SEX_CHOICES = (
        ('Female', _('Female')),
        ('Male', _('Male')),
        ('Intersex', _('Intersex')),
    )

    sex = models.CharField(_("Sex"), max_length=50, choices=SEX_CHOICES, null=True)
    insurance = models.ForeignKey('Insurance', on_delete=models.CASCADE, verbose_name=_("Insurance"))
    medications = models.CharField(_("Medications"), max_length=200, null=True, blank=True)
    allergies = models.CharField(_("Allergies"), max_length=200, null=True, blank=True)
    medical_conditions = models.CharField(_("Medical Conditions"), max_length=200, null=True, blank=True)
    family_history = models.CharField(_("Family History"), max_length=200, null=True, blank=True)
    additional_info = models.CharField(_("Additional Info"), max_length=400, null=True, blank=True)

    class Meta:
        verbose_name = _("Medical Information")
        verbose_name_plural = _("Medical Information Records")

    def json_object(self):
        return {
            'sex': self.sex,
            'insurance': {
                'company': self.insurance.company,
                'policy_number': self.insurance.policy_number
            },
            'medications': self.medications,
            'allergies': self.allergies,
            'medical_conditions': self.medical_conditions,
            'family_history': self.family_history,
            'additional_info': self.additional_info,
        }

    def __repr__(self):
        return (("Sex: {0}, Insurance: {1}, Medications: {2}, Allergies: {3}, " +
                 "Medical Conditions: {4}, Family History: {5}, " +
                 "Additional Info: {6}").format(
            self.sex, repr(self.insurance), self.medications,
            self.allergies, self.medical_conditions,
            self.family_history, self.additional_info
        ))

    def __str__(self):
        return "{0} with {1}".format(self.sex, self.insurance)


class Hospital(DirtyFieldsMixin, models.Model):
    name = models.CharField(_("Name"), max_length=200)
    address = models.CharField(_("Address"), max_length=200)
    city = models.CharField(_("City"), max_length=200)
    state = models.CharField(_("State"), max_length=30)
    zipcode = models.CharField(_("Zip Code"), max_length=20)

    class Meta:
        verbose_name = _("Hospital")
        verbose_name_plural = _("Hospitals")

    def json_object(self):
        return {
            'name': self.name,
            'address': self.address,
            'city': self.city,
            'state': self.state,
            'zipcode': self.zipcode,
        }

    def __repr__(self):
        return ("%s at %s, %s, %s %s" % (self.name, self.address, self.city, self.state, self.zipcode))

    def __str__(self):
        return "{0} with {1}".format(self.name, self.address)

    def admit(self, user):
        # Allow multiple concurrent hospital stays
        HospitalStay.objects.create(patient=user, admission=timezone.now(), hospital=self)

    def discharge(self, user):
        user_query = HospitalStay.objects.filter(patient=user, hospital=self)
        if user_query.exists():
            stay = user_query.first()
            stay.discharge = timezone.now()
            stay.save()

    def users_in_group(self, group_name):
        return list({stay.patient for stay in HospitalStay.objects.filter(hospital=self, patient__groups__name=group_name).distinct().order_by('patient__first_name', 'patient__last_name').all()})


class User(DirtyFieldsMixin, AbstractUser):
    date_of_birth = models.DateField(_("Date of Birth"), blank=True, null=True)
    nationality = CountryField(_("Nationality"), blank=True, null=True)  # Use CountryField for automatic country choices
    phone_number = models.CharField(_("Phone Number"), max_length=30, validators=[
        RegexValidator(regex=r'^\+?1?\d{9,15}$', message=_("Phone number must be entered in the format: '+999999999'. Up to 15 digits allowed."))
    ])
    medical_information = models.ForeignKey(MedicalInformation, null=True, blank=True, on_delete=models.SET_NULL, verbose_name=_("Medical Information"))
    emergency_contact = models.ForeignKey(EmergencyContact, null=True, on_delete=models.SET_NULL, verbose_name=_("Emergency Contact"))
    thumbnail = models.ImageField(_("Profile Picture"), upload_to='profile_pictures/', blank=True, null=True)
    referral_code = models.CharField(_("Referral Code"), max_length=100, blank=True, null=True)
    referred_by = models.CharField(_("Referred By"), max_length=100, blank=True, null=True)  # Increased length for flexibility
    thread_id = models.CharField(_("Thread ID"), max_length=255, null=True, blank=True)
    beyondblog_profileid = models.CharField(_("Blog Profile ID"), max_length=100, null=True, blank=True)

    # New fields for logging purposes
    is_online = models.BooleanField(_("Is Online"), default=False)
    last_login_time = models.DateTimeField(_("Last Login Time"), null=True, blank=True)
    last_logout_time = models.DateTimeField(_("Last Logout Time"), null=True, blank=True)

    REQUIRED_FIELDS = ['date_of_birth', 'nationality', 'phone_number', 'email', 'first_name', 'last_name']

    def unread_message_count(self):
        return Message.objects.filter(group__members__pk=self.pk).exclude(read_members__pk=self.pk).distinct().count()

    def hospital(self):
        return HospitalStay.objects.filter(patient=self, discharge__isnull=True).values('hospital', 'admission')

    def __str__(self):
        return " {0}".format(self.first_name)


class Referral(DirtyFieldsMixin, models.Model):
    referrer = models.ForeignKey(User, related_name='referrals', on_delete=models.CASCADE, verbose_name=_("Referrer"))
    referred = models.ForeignKey(User, related_name='referred_users', on_delete=models.CASCADE, null=True, blank=True, verbose_name=_("Referred"))
    code = models.CharField(_("Code"), max_length=100)
    created_at = models.DateTimeField(_("Created At"), auto_now_add=True)

    class Meta:
        verbose_name = _("Referral")
        verbose_name_plural = _("Referrals")

    def __str__(self):
        return f"{self.referrer.username} -> {self.code}"

class Appointment(DirtyFieldsMixin, models.Model):
    patient = models.ForeignKey(User, related_name='patient_appointments', on_delete=models.CASCADE, verbose_name=_("Patient"))
    doctor = models.ForeignKey(User, related_name='doctor_appointments', on_delete=models.CASCADE, verbose_name=_("Doctor"))
    date = models.DateTimeField(_("Date"))
    duration = models.IntegerField(_("Duration"))

    class Meta:
        verbose_name = _("Appointment")
        verbose_name_plural = _("Appointments")

    def json_object(self):
        return {
            'date': self.date.isoformat(),
            'end': self.end().isoformat(),
            'patient': self.patient.get_full_name(),
            'doctor': self.doctor.get_full_name(),
        }

    def end(self):
        return self.date + timedelta(minutes=self.duration)

    def __repr__(self):
        return '{0} minutes on {1}, {2} with {3}'.format(self.duration, self.date, self.patient, self.doctor)

    def __str__(self):
        return " {0} appointment with {1}".format(self.patient, self.doctor)


class HospitalStay(DirtyFieldsMixin, models.Model):
    patient = models.ForeignKey(User, on_delete=models.CASCADE, verbose_name=_("Patient"))
    admission = models.DateTimeField(_("Admission"))
    discharge = models.DateTimeField(_("Discharge"), null=True, blank=True)
    hospital = models.ForeignKey(Hospital, on_delete=models.CASCADE, verbose_name=_("Hospital"))

    class Meta:
        verbose_name = _("Hospital Stay")
        verbose_name_plural = _("Hospital Stays")

    def __str__(self):
        return "{0} stay in {1}".format(self.patient, self.hospital)


class Prescription(DirtyFieldsMixin, models.Model):
    patient = models.ForeignKey(User, on_delete=models.CASCADE, verbose_name=_("Patient"))
    name = models.CharField(_("Name"), max_length=200)
    dosage = models.CharField(_("Dosage"), max_length=200)
    directions = models.CharField(_("Directions"), max_length=1000)
    prescribed = models.DateTimeField(_("Prescribed"))
    active = models.BooleanField(_("Active"))

    class Meta:
        verbose_name = _("Prescription")
        verbose_name_plural = _("Prescriptions")

    def json_object(self):
        return {
            'name': self.name,
            'dosage': self.dosage,
            'directions': self.directions,
            'prescribed': self.prescribed.isoformat(),
            'active': self.active
        }

    def __repr__(self):
        return '{0} of {1}: {2}'.format(self.dosage, self.name, self.directions)

    def __str__(self):
        return "{0} for {1}".format(self.name, self.patient)


class MessageGroup(DirtyFieldsMixin, models.Model):
    name = models.CharField(_("Name"), max_length=140)
    members = models.ManyToManyField(User, verbose_name=_("Members"))

    class Meta:
        verbose_name = _("Message Group")
        verbose_name_plural = _("Message Groups")

    def latest_message(self):
        if self.messages.count() == 0:
            return None
        return self.messages.order_by('-date').first()

    def combined_names(self, full=False):
        names_count = self.members.count()
        extras = names_count - 3
        members = self.members.all()
        if not full:
            members = members[:3]
        names = ", ".join([m.get_full_name() for m in members])
        if extras > 0 and not full:
            names += " and %d other%s" % (extras, "" if extras == 1 else "s")
        return names


class Message(DirtyFieldsMixin, models.Model):
    sender = models.ForeignKey(User, related_name='sent_messages', on_delete=models.CASCADE, verbose_name=_("Sender"))
    group = models.ForeignKey(MessageGroup, related_name='messages', on_delete=models.CASCADE, verbose_name=_("Group"))
    body = models.TextField(_("Body"))
    date = models.DateTimeField(_("Date"))
    read_members = models.ManyToManyField(User, related_name='read_messages', verbose_name=_("Read Members"))

    class Meta:
        verbose_name = _("Message")
        verbose_name_plural = _("Messages")

    def preview_text(self):
        return (self.body[:100] + "...") if len(self.body) > 100 else self.body


class Subscription(DirtyFieldsMixin, models.Model):
    email = models.CharField(_("Email"), max_length=200)

    class Meta:
        verbose_name = _("Subscription")
        verbose_name_plural = _("Subscriptions")

    def __str__(self):
        return self.email


class Contact(DirtyFieldsMixin, models.Model):
    first_name = models.CharField(_("First Name"), max_length=200)
    last_name = models.CharField(_("Last Name"), max_length=200)
    email = models.CharField(_("Email"), max_length=200)
    message = models.TextField(_("Message"))

    class Meta:
        verbose_name = _("Contact")
        verbose_name_plural = _("Contacts")

    def __str__(self):
        return "{0} for {1}".format(self.first_name, self.last_name)


class EmailTemplate(DirtyFieldsMixin, models.Model):
    name = models.CharField(_("Name"), max_length=255, unique=True)
    subject = models.CharField(_("Subject"), max_length=255)
    body = RichTextField(_("Body"))  # Use CKEditor for rich text editing

    class Meta:
        verbose_name = _("Email Template")
        verbose_name_plural = _("Email Templates")

    def __str__(self):
        return self.name


class TreatmentProduct(models.Model):
    CATEGORY_CHOICES = [
        ('Implants', _('Implants')),
        ('Crowns', _('Crowns')),
        ('Dental Procedures', _('Dental Procedures')),
        ('Additional Services', _('Additional Services')),
    ]

    name = models.CharField(_("Name"), max_length=255)
    slug = models.SlugField(_("Slug"), unique=True, blank=True, null=True)
    category = models.CharField(_("Category"), max_length=50, choices=CATEGORY_CHOICES)
    description = models.TextField(_("Description"), blank=True, null=True)
    price = models.DecimalField(_("Price"), max_digits=10, decimal_places=2, blank=True, null=True)
    max_discount_percentage = models.DecimalField(_("Max Discount Percentage"), max_digits=5, decimal_places=2, default=35.00)
    country_of_origin = CountryField(_("Country of Origin"), blank=True, null=True, help_text=_("Country where this product is manufactured or originates from"))
    is_active = models.BooleanField(_("Is Active"), default=True)
    image = models.ImageField(_("Image"), upload_to='products/%Y/%m/%d/', blank=True, null=True)

    class Meta:
        verbose_name = _("Treatment Product")
        verbose_name_plural = _("Treatment Products")

    def save(self, *args, **kwargs):
        if not self.slug:
            self.slug = slugify(self.name)
        super().save(*args, **kwargs)

    def __str__(self):
        return self.name

    def image_filename(self):
        if self.image:
            return os.path.basename(self.image.name)
        return None


class TreatmentPlan(models.Model):
    patient = models.ForeignKey(User, on_delete=models.CASCADE, related_name='patient_treatment_plans', verbose_name=_("Patient"))
    doctor = models.ForeignKey(User, on_delete=models.CASCADE, related_name='doctor_treatment_plans', verbose_name=_("Doctor"))
    products = models.ManyToManyField('TreatmentProduct', through='TreatmentPlanItem', verbose_name=_("Products"))
    subtotal = models.DecimalField(_("Subtotal"), max_digits=10, decimal_places=2, blank=True, null=True)
    final_discount_percentage = models.DecimalField(_("Final Discount Percentage"), max_digits=5, decimal_places=2, default=0.00)
    discount_amount = models.DecimalField(_("Discount Amount"), max_digits=10, decimal_places=2, blank=True, null=True)
    total_price = models.DecimalField(_("Total Price"), max_digits=10, decimal_places=2, blank=True, null=True)
    created_at = models.DateTimeField(_("Created At"), auto_now_add=True)
    updated_at = models.DateTimeField(_("Updated At"), auto_now=True)

    class Meta:
        verbose_name = _("Treatment Plan")
        verbose_name_plural = _("Treatment Plans")

    def calculate_subtotal(self):
        """Calculate the subtotal from all items in the treatment plan."""
        return sum(item.item_total() for item in self.treatmentplanitem_set.all())

    def calculate_discount_amount(self):
        """Calculate the discount amount based on the subtotal and final discount percentage."""
        return (self.calculate_subtotal() * self.final_discount_percentage) / 100

    def calculate_total_price(self):
        """Calculate the total price after applying the final discount."""
        return self.calculate_subtotal() - self.calculate_discount_amount()

    def save(self, *args, **kwargs):
        # First save to ensure we have a primary key and related objects can be saved
        super().save(*args, **kwargs)
        
        # Only calculate if we have items
        if self.treatmentplanitem_set.exists():
            # Calculate values after items are saved
            self.subtotal = self.calculate_subtotal()
            self.discount_amount = self.calculate_discount_amount()
            self.total_price = self.calculate_total_price()
            
            # Save again with the updated calculated fields
            super().save(update_fields=['subtotal', 'discount_amount', 'total_price', 'updated_at'])

    def __str__(self):
        return f"Treatment Plan for {self.patient.get_full_name()} by Dr. {self.doctor.get_full_name()}"


class TreatmentPlanItem(models.Model):
    treatment_plan = models.ForeignKey(TreatmentPlan, on_delete=models.CASCADE, verbose_name=_("Treatment Plan"))
    product = models.ForeignKey(TreatmentProduct, on_delete=models.CASCADE, verbose_name=_("Product"))
    quantity = models.PositiveIntegerField(_("Quantity"))
    discount_percentage = models.DecimalField(_("Discount Percentage"), max_digits=5, decimal_places=2, default=0.00)

    class Meta:
        verbose_name = _("Treatment Plan Item")
        verbose_name_plural = _("Treatment Plan Items")

    def __str__(self):
        return f"{self.quantity} x {self.product.name} for {self.treatment_plan}"

    def item_total(self):
        """Calculate the total cost for this item after applying its discount."""
        total_price = self.product.price * self.quantity
        discount = (total_price * self.discount_percentage) / 100
        return total_price - discount

    def clean(self):
        """Ensure the discount doesn't exceed the max allowed by the product."""
        if self.discount_percentage > self.product.max_discount_percentage:
            raise ValidationError(
                _(
                    "The discount percentage for '%(product)s' cannot exceed %(max_discount)s%%. "
                ) % {
                    'product': self.product.name,
                    'max_discount': self.product.max_discount_percentage
                }
            )

    def save(self, *args, **kwargs):
        self.clean()  # Ensure validation is run before saving
        super().save(*args, **kwargs)


class MedicalFile(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name='medical_files')
    medical_information = models.ForeignKey('MedicalInformation', on_delete=models.SET_NULL, null=True, blank=True, related_name='files')
    file = models.FileField(upload_to=user_directory_path)
    upload_timestamp = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"File {self.file.name} for user {self.user.username}"

    def file_name(self):
        return self.file.name.split('/')[-1]



class Hotel(models.Model):
    name = models.CharField(_("Hotel Name"), max_length=255)
    address = models.TextField(_("Address"))
    room_type = models.CharField(_("Room Type"), max_length=50, choices=[
        ('Single', _('Single')),
        ('Double', _('Double')),
        ('Suite', _('Suite')),
        ('Family', _('Family')),
    ])
    price_per_night = models.DecimalField(_("Price Per Night"), max_digits=10, decimal_places=2)
    amenities = models.TextField(_("Amenities"), blank=True, help_text=_("Comma-separated list of amenities"))
    availability = models.BooleanField(_("Availability"), default=True)
    rating = models.FloatField(_("Rating"), null=True, blank=True)

    class Meta:
        verbose_name = _("Hotel")
        verbose_name_plural = _("Hotels")

    def __str__(self):
        return f"{self.name} ({self.room_type})"



class Accommodation(models.Model):
    user = models.ForeignKey(
        'User', on_delete=models.SET_NULL, null=True, blank=True, verbose_name=_("User")
    )
    treatment_plan = models.ForeignKey(
        'TreatmentPlan', on_delete=models.SET_NULL, null=True, blank=True, verbose_name=_("Treatment Plan")
    )
    hotel = models.ForeignKey(
        'Hotel', on_delete=models.SET_NULL, null=True, blank=True, verbose_name=_("Hotel")
    )
    duration_of_stay = models.PositiveIntegerField(_("Duration of Stay (in nights)"), default=1)

    class Meta:
        verbose_name = _("Accommodation")
        verbose_name_plural = _("Accommodations")

    def __str__(self):
        return f"{self.hotel.name} ({self.duration_of_stay} nights) - {self.user.get_full_name()}"




from django.db import models
from django.utils.translation import gettext_lazy as _

class FlightReservation(models.Model):
    user = models.ForeignKey(
        'User',  # Links each reservation to a single User
        on_delete=models.CASCADE,  # Delete the reservation if the user is deleted
        related_name='flight_reservations',  # Allows reverse access via user.flight_reservations
        verbose_name=_("User")
    )
    arrival_date = models.DateField(_("Arrival Date"))
    arrival_hour = models.TimeField(_("Arrival Hour"))
    arrival_flight_number = models.CharField(_("Arrival Flight Number"), max_length=50)
    departure_date = models.DateField(_("Departure Date"))
    departure_hour = models.TimeField(_("Departure Hour"))
    departure_flight_number = models.CharField(_("Departure Flight Number"), max_length=50)

    class Meta:
        verbose_name = _("Flight Reservation")
        verbose_name_plural = _("Flight Reservations")

    def __str__(self):
        return f"Flight {self.arrival_flight_number} on {self.arrival_date}"




from django.db import models
from django.utils.translation import gettext_lazy as _

class PatientSchedule(models.Model):
    user = models.ForeignKey(
        'User', on_delete=models.CASCADE, verbose_name=_("Patient")
    )
    hospital = models.ForeignKey(
        'Hospital', on_delete=models.SET_NULL, null=True, blank=True, verbose_name=_("Hospital")
    )
    accommodation = models.ForeignKey(
        'Accommodation', on_delete=models.SET_NULL, null=True, blank=True, verbose_name=_("Accommodation")
    )
    flight_reservation = models.ForeignKey(
        'FlightReservation', on_delete=models.SET_NULL, null=True, blank=True, verbose_name=_("Flight Reservation")
    )
    appointment = models.ForeignKey(
        'Appointment', on_delete=models.CASCADE, verbose_name=_("Appointment")
    )
    notes = models.TextField(_("Notes"), blank=True, null=True)

    class Meta:
        verbose_name = _("Patient Schedule")
        verbose_name_plural = _("Patient Schedules")

    def __str__(self):
        return f"Schedule for {self.user.get_full_name()} with appointment on {self.appointment.date}"
