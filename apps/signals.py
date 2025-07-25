print("[DEBUG] signals.py is loaded")

from django.dispatch import receiver
from django.contrib.auth.signals import user_logged_in, user_logged_out
from django.db.models.signals import post_save, post_delete
from actstream.actions import action
from django.utils.timezone import now
from django.contrib.auth import get_user_model
from django.utils.translation import gettext_lazy as _  # For translation
from django.core.mail import send_mail
from django.conf import settings

from .models import (
    User, Insurance, EmergencyContact, MedicalInformation,
    MedicalFile, Hospital, Referral, Appointment, HospitalStay, Prescription,
    MessageGroup, Message, Subscription, Contact, EmailTemplate,
    TreatmentPlanItem, TreatmentPlan
)

User = get_user_model()

# Helper function to get user's group
def get_user_group(user):
    groups = user.groups.all()
    if groups.exists():
        return ', '.join([group.name for group in groups])
    return _('No Group')

# Helper function to send email
def send_signal_email(subject, message):
    print(f"[DEBUG] Preparing to send email: {subject}")
    try:
        send_mail(
            subject=subject,
            message=message,
            from_email=settings.DEFAULT_FROM_EMAIL,
            recipient_list=['lona2023.io51023@gmail.com'],  # Replace with your recipient email
            fail_silently=False,
        )
        print(f"[DEBUG] Email sent successfully: {subject}")
    except Exception as e:
        print(f"[ERROR] Failed to send email: {e}")

# User login and logout signals
@receiver(user_logged_in)
def log_user_login(sender, request, user, **kwargs):
    user_group = get_user_group(user)
    log_message = f"User {user.username} (Group: {user_group}) logged in."
    print(f"[DEBUG] {log_message}")

    send_signal_email("User Logged In", log_message)

    user.is_online = True
    user.last_login_time = now()
    user.save(update_fields=['is_online', 'last_login_time'])
    action.send(user, verb=f'logged in as {user_group}')

@receiver(user_logged_out)
def log_user_logout(sender, request, user, **kwargs):
    user_group = get_user_group(user)
    log_message = f"User {user.username} (Group: {user_group}) logged out."
    print(f"[DEBUG] {log_message}")

    send_signal_email("User Logged Out", log_message)

    user.is_online = False
    user.last_logout_time = now()
    user.save(update_fields=['is_online', 'last_logout_time'])
    action.send(user, verb=f'logged out as {user_group}')

# User Model Signals
@receiver(post_save, sender=User)
def log_user_profile_update(sender, instance, created, **kwargs):
    if not created:
        user_group = get_user_group(instance)
        log_message = f"User {instance.username} (Group: {user_group}) updated profile."
        print(f"[DEBUG] {log_message}")

        send_signal_email("User Profile Updated", log_message)

@receiver(post_save, sender=Referral)
def log_user_referral(sender, instance, created, **kwargs):
    if created and instance.referred:
        referrer_group = get_user_group(instance.referrer)
        referred_group = get_user_group(instance.referred)
        log_message = (f"User {instance.referred.username} (Group: {referred_group}) "
                       f"signed up via referral by {instance.referrer.username} (Group: {referrer_group}).")
        print(f"[DEBUG] {log_message}")

        send_signal_email("New Referral", log_message)

# HospitalStay Model Signals
@receiver(post_save, sender=HospitalStay)
def log_hospital_stay(sender, instance, created, **kwargs):
    patient_group = get_user_group(instance.patient)
    if created and not instance.discharge:
        log_message = f"Patient {instance.patient.username} admitted to {instance.hospital.name}."
        print(f"[DEBUG] {log_message}")

        send_signal_email("Hospital Admission", log_message)
    elif instance.discharge:
        log_message = f"Patient {instance.patient.username} discharged from {instance.hospital.name}."
        print(f"[DEBUG] {log_message}")

        send_signal_email("Hospital Discharge", log_message)

# Appointment Model Signals
@receiver(post_save, sender=Appointment)
def log_appointment(sender, instance, created, **kwargs):
    patient_group = get_user_group(instance.patient)
    if created:
        log_message = f"New appointment for patient {instance.patient.username} created."
        print(f"[DEBUG] {log_message}")

        send_signal_email("New Appointment Created", log_message)

@receiver(post_delete, sender=Appointment)
def log_appointment_cancellation(sender, instance, **kwargs):
    log_message = f"Appointment for patient {instance.patient.username} was cancelled."
    print(f"[DEBUG] {log_message}")

    send_signal_email("Appointment Cancelled", log_message)

# Prescription Model Signals
@receiver(post_save, sender=Prescription)
def log_prescription(sender, instance, created, **kwargs):
    if created:
        log_message = f"New prescription for patient {instance.patient.username} created."
        print(f"[DEBUG] {log_message}")

        send_signal_email("New Prescription Created", log_message)

# Message Model Signals
@receiver(post_save, sender=Message)
def log_message_sent(sender, instance, created, **kwargs):
    if created:
        log_message = f"New message sent by {instance.sender.username}."
        print(f"[DEBUG] {log_message}")

        send_signal_email("New Message Sent", log_message)

# MedicalFile Model Signals
@receiver(post_save, sender=MedicalFile)
def log_medical_file_upload(sender, instance, created, **kwargs):
    if created:
        log_message = f"User {instance.user.username} uploaded medical file {instance.file.name}."
        print(f"[DEBUG] {log_message}")

        send_signal_email("Medical File Uploaded", log_message)

@receiver(post_delete, sender=MedicalFile)
def log_medical_file_deletion(sender, instance, **kwargs):
    log_message = f"User {instance.user.username} deleted medical file {instance.file.name}."
    print(f"[DEBUG] {log_message}")

    send_signal_email("Medical File Deleted", log_message)
