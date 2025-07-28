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

# Import Invoice Ninja integration utilities
from .invoice_ninja_utils import process_user_for_invoice_ninja_sync

User = get_user_model()

# Helper function to get user's group
def get_user_group(user):
    groups = user.groups.all()
    if groups.exists():
        return ', '.join([group.name for group in groups])
    return _('No Group')

# Helper function to send email - DISABLED TO PREVENT EMAIL FLOODING
def send_signal_email(subject, message):
    print(f"[DEBUG] Email sending DISABLED - Would have sent email: {subject}")
    # try:
    #     send_mail(
    #         subject=subject,
    #         message=message,
    #         from_email=settings.DEFAULT_FROM_EMAIL,
    #         recipient_list=['lona2023.io51023@gmail.com'],  # Replace with your recipient email
    #         fail_silently=False,
    #     )
    #     print(f"[DEBUG] Email sent successfully: {subject}")
    # except Exception as e:
    #     print(f"[ERROR] Failed to send email: {e}")

# User login and logout signals
@receiver(user_logged_in)
def log_user_login(sender, request, user, **kwargs):
    user_group = get_user_group(user)
    log_message = f"User {user.username} (Group: {user_group}) logged in."
    print(f"[DEBUG] {log_message}")

    # Email sending disabled to prevent flooding
    # send_signal_email("User Logged In", log_message)

    user.is_online = True
    user.last_login_time = now()
    user.save(update_fields=['is_online', 'last_login_time'])
    action.send(user, verb=f'logged in as {user_group}')

@receiver(user_logged_out)
def log_user_logout(sender, request, user, **kwargs):
    user_group = get_user_group(user)
    log_message = f"User {user.username} (Group: {user_group}) logged out."
    print(f"[DEBUG] {log_message}")

    # Email sending disabled to prevent flooding
    # send_signal_email("User Logged Out", log_message)

    user.is_online = False
    user.last_logout_time = now()
    user.save(update_fields=['is_online', 'last_logout_time'])
    action.send(user, verb=f'logged out as {user_group}')

# User Model Signals
@receiver(post_save, sender=User)
def log_user_profile_update(sender, instance, created, **kwargs):
    # Only log profile updates if it's not a login-related update
    if not created and kwargs.get('update_fields') != ['is_online', 'last_login_time']:
        user_group = get_user_group(instance)
        log_message = f"User {instance.username} (Group: {user_group}) updated profile."
        print(f"[DEBUG] {log_message}")

        # Email sending disabled to prevent flooding
        # send_signal_email("User Profile Updated", log_message)

@receiver(post_save, sender=Referral)
def log_user_referral(sender, instance, created, **kwargs):
    if created and instance.referred:
        referrer_group = get_user_group(instance.referrer)
        referred_group = get_user_group(instance.referred)
        log_message = (f"User {instance.referred.username} (Group: {referred_group}) "
                       f"signed up via referral by {instance.referrer.username} (Group: {referrer_group}).")
        print(f"[DEBUG] {log_message}")

        # Email sending disabled to prevent flooding
        # send_signal_email("New Referral", log_message)

# HospitalStay Model Signals
@receiver(post_save, sender=HospitalStay)
def log_hospital_stay(sender, instance, created, **kwargs):
    patient_group = get_user_group(instance.patient)
    if created and not instance.discharge:
        log_message = f"Patient {instance.patient.username} admitted to {instance.hospital.name}."
        print(f"[DEBUG] {log_message}")

        # Email sending disabled to prevent flooding
        # send_signal_email("Hospital Admission", log_message)
    elif instance.discharge:
        log_message = f"Patient {instance.patient.username} discharged from {instance.hospital.name}."
        print(f"[DEBUG] {log_message}")

        # Email sending disabled to prevent flooding
        # send_signal_email("Hospital Discharge", log_message)

# Appointment Model Signals
@receiver(post_save, sender=Appointment)
def log_appointment(sender, instance, created, **kwargs):
    patient_group = get_user_group(instance.patient)
    if created:
        log_message = f"New appointment for patient {instance.patient.username} created."
        print(f"[DEBUG] {log_message}")

        # Email sending disabled to prevent flooding
        # send_signal_email("New Appointment Created", log_message)

@receiver(post_delete, sender=Appointment)
def log_appointment_cancellation(sender, instance, **kwargs):
    log_message = f"Appointment for patient {instance.patient.username} was cancelled."
    print(f"[DEBUG] {log_message}")

    # Email sending disabled to prevent flooding
    # send_signal_email("Appointment Cancelled", log_message)

# Prescription Model Signals
@receiver(post_save, sender=Prescription)
def log_prescription(sender, instance, created, **kwargs):
    if created:
        log_message = f"New prescription for patient {instance.patient.username} created."
        print(f"[DEBUG] {log_message}")

        # Email sending disabled to prevent flooding
        # send_signal_email("New Prescription Created", log_message)

# Message Model Signals
@receiver(post_save, sender=Message)
def log_message_sent(sender, instance, created, **kwargs):
    if created:
        log_message = f"New message sent by {instance.sender.username}."
        print(f"[DEBUG] {log_message}")

        # Email sending disabled to prevent flooding
        # send_signal_email("New Message Sent", log_message)

# MedicalFile Model Signals
@receiver(post_save, sender=MedicalFile)
def log_medical_file_upload(sender, instance, created, **kwargs):
    if created:
        log_message = f"User {instance.user.username} uploaded medical file {instance.file.name}."
        print(f"[DEBUG] {log_message}")

        # Email sending disabled to prevent flooding
        # send_signal_email("Medical File Uploaded", log_message)

@receiver(post_delete, sender=MedicalFile)
def log_medical_file_deletion(sender, instance, **kwargs):
    log_message = f"User {instance.user.username} deleted medical file {instance.file.name}."
    print(f"[DEBUG] {log_message}")



# =============================================================================
# INVOICE NINJA INTEGRATION SIGNALS
# =============================================================================

@receiver(post_save, sender=User)
def sync_user_with_invoice_ninja(sender, instance, created, **kwargs):
    """
    Signal handler to sync Django users with Invoice Ninja when a user is created or updated.
    
    This signal is triggered after a User instance is saved to the database.
    It handles the initial synchronization of user data with Invoice Ninja.
    
    TEMPORARILY DISABLED TO PREVENT BLOCKING DURING SIGNUP
    """
    # Invoice Ninja sync temporarily disabled to prevent blocking during signup
    print(f"[DEBUG] Invoice Ninja sync DISABLED for user {instance.id} to prevent signup blocking")
    return
    
    # Only process if the user is newly created or if specific Invoice Ninja related fields changed
    if created:
        print(f"[DEBUG] New user created: {instance.username} (ID: {instance.id}). Initiating Invoice Ninja sync.")
        
        # Process user for Invoice Ninja synchronization
        try:
            success = process_user_for_invoice_ninja_sync(instance)
            if success:
                print(f"[DEBUG] Invoice Ninja sync initiated successfully for user {instance.id}")
                action.send(instance, verb='initiated Invoice Ninja synchronization')
            else:
                print(f"[WARNING] Failed to initiate Invoice Ninja sync for user {instance.id}")
                action.send(instance, verb='failed to initiate Invoice Ninja synchronization')
        except Exception as e:
            print(f"[ERROR] Error during Invoice Ninja sync for user {instance.id}: {e}")
            action.send(instance, verb=f'encountered error during Invoice Ninja sync: {str(e)}')
    
    elif hasattr(instance, '_state') and instance._state.adding is False:
        # Check if referral-related fields were updated for existing users
        if hasattr(instance, '_old_referral_code') or hasattr(instance, '_old_referred_by'):
            old_referral_code = getattr(instance, '_old_referral_code', None)
            old_referred_by = getattr(instance, '_old_referred_by', None)
            
            if (old_referral_code != instance.referral_code or 
                old_referred_by != instance.referred_by):
                
                print(f"[DEBUG] Referral data updated for user {instance.id}. Re-syncing with Invoice Ninja.")
                
                try:
                    # Mark for re-sync if referral data changed
                    instance.invoiceninja_sync_status = 'retry'
                    instance.save(update_fields=['invoiceninja_sync_status'])
                    
                    success = process_user_for_invoice_ninja_sync(instance)
                    if success:
                        print(f"[DEBUG] Invoice Ninja re-sync initiated for user {instance.id}")
                        action.send(instance, verb='re-synced with Invoice Ninja due to referral data update')
                except Exception as e:
                    print(f"[ERROR] Error during Invoice Ninja re-sync for user {instance.id}: {e}")


# Pre-save signal to track field changes for existing users - TEMPORARILY DISABLED
@receiver(post_save, sender=User)
def track_user_field_changes(sender, instance, **kwargs):
    """
    Track changes to specific fields for Invoice Ninja re-synchronization.
    This runs before the main sync signal to capture old values.
    
    TEMPORARILY DISABLED TO PREVENT BLOCKING DURING SIGNUP
    """
    # Field tracking disabled to prevent signup blocking
    print(f"[DEBUG] User field tracking DISABLED for user {instance.id} to prevent signup blocking")
    return
    
    if instance.pk:  # Only for existing users
        try:
            old_instance = User.objects.get(pk=instance.pk)
            instance._old_referral_code = old_instance.referral_code
            instance._old_referred_by = old_instance.referred_by
        except User.DoesNotExist:
            pass  # New user, no need to track changes
