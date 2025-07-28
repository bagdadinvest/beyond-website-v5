"""
Invoice Ninja Integration Utilities

This module handles the synchronization of Django users with Invoice Ninja clients.
It provides utilities for webhook sending, data serialization, and sync status management.

Author: Django-Invoice Ninja Integration Team
Created: 2025-01-25
"""

import json
import logging
import requests
from django.conf import settings
from django.utils import timezone
from django.contrib.auth import get_user_model
from django.core.serializers.json import DjangoJSONEncoder

# Set up logging
logger = logging.getLogger(__name__)

User = get_user_model()


class InvoiceNinjaIntegrationError(Exception):
    """Custom exception for Invoice Ninja integration errors"""
    pass


class UserDataSerializer:
    """Serializes Django User model data for Invoice Ninja integration"""
    
    @staticmethod
    def serialize_user_for_invoice_ninja(user):
        """
        Serializes a Django User instance for Invoice Ninja client creation.
        
        Args:
            user: Django User instance
            
        Returns:
            Dictionary containing user data formatted for Invoice Ninja
        """
        # Get emergency contact information if available
        emergency_contact_data = {}
        if user.emergency_contact:
            emergency_contact_data = {
                'emergency_contact_name': f"{user.emergency_contact.first_name} {user.emergency_contact.last_name}",
                'emergency_contact_phone': user.emergency_contact.phone_number,
                'emergency_contact_relationship': user.emergency_contact.relationship,
            }
        
        # Get medical information if available
        medical_info_data = {}
        if user.medical_information:
            medical_info_data = {
                'medical_sex': user.medical_information.sex,
                'medical_conditions': user.medical_information.medical_conditions,
                'allergies': user.medical_information.allergies,
                'medications': user.medical_information.medications,
            }
            
            # Add insurance information if available
            if user.medical_information.insurance:
                medical_info_data.update({
                    'insurance_policy': user.medical_information.insurance.policy_number,
                    'insurance_company': user.medical_information.insurance.company,
                })
        
        # Construct the main user data payload
        user_data = {
            'django_user_id': user.id,
            'username': user.username,
            'email': user.email,
            'first_name': user.first_name,
            'last_name': user.last_name,
            'full_name': f"{user.first_name} {user.last_name}".strip(),
            'phone_number': user.phone_number,
            'date_of_birth': user.date_of_birth.isoformat() if user.date_of_birth else None,
            'nationality': str(user.nationality) if user.nationality else None,
            'nationality_name': user.nationality.name if user.nationality else None,
            'referral_code': user.referral_code,
            'referred_by': user.referred_by,
            'date_joined': user.date_joined.isoformat(),
            'is_active': user.is_active,
            'sync_timestamp': timezone.now().isoformat(),
            
            # Custom fields for Invoice Ninja (will be mapped to custom_value1, custom_value2, etc.)
            'custom_fields': {
                'referral_code': user.referral_code,
                'referred_by': user.referred_by,
                'nationality': str(user.nationality) if user.nationality else None,
                'django_user_id': str(user.id),
                'signup_date': user.date_joined.strftime('%Y-%m-%d'),
            }
        }
        
        # Add emergency contact and medical data if available
        user_data.update(emergency_contact_data)
        user_data.update(medical_info_data)
        
        return user_data


class WebhookSender:
    """Handles sending webhooks to external services"""
    
    def __init__(self):
        self.webhook_url = getattr(settings, 'INVOICE_NINJA_WEBHOOK_URL', None)
        self.webhook_timeout = getattr(settings, 'INVOICE_NINJA_WEBHOOK_TIMEOUT', 30)
        self.webhook_secret = getattr(settings, 'INVOICE_NINJA_WEBHOOK_SECRET', None)
        
    def send_user_created_webhook(self, user):
        """
        Sends a webhook notification when a new user is created.
        
        Args:
            user: The Django User instance that was created
            
        Returns:
            bool: True if webhook was sent successfully, False otherwise
        """
        if not self.webhook_url:
            logger.warning("INVOICE_NINJA_WEBHOOK_URL not configured. Skipping webhook.")
            return False
            
        try:
            # Serialize user data
            user_data = UserDataSerializer.serialize_user_for_invoice_ninja(user)
            
            # Prepare webhook payload
            payload = {
                'event': 'user.created',
                'data': user_data,
                'timestamp': timezone.now().isoformat(),
            }
            
            # Prepare headers
            headers = {
                'Content-Type': 'application/json',
                'User-Agent': 'Django-InvoiceNinja-Integration/1.0',
            }
            
            # Add webhook secret if configured
            if self.webhook_secret:
                headers['X-Webhook-Secret'] = self.webhook_secret
            
            # Send the webhook
            logger.info(f"Sending user creation webhook for user {user.id} to {self.webhook_url}")
            
            response = requests.post(
                self.webhook_url,
                json=payload,
                headers=headers,
                timeout=self.webhook_timeout
            )
            
            response.raise_for_status()
            
            logger.info(f"Webhook sent successfully for user {user.id}. Response: {response.status_code}")
            return True
            
        except requests.RequestException as e:
            logger.error(f"Failed to send webhook for user {user.id}: {e}")
            return False
        except Exception as e:
            logger.error(f"Unexpected error sending webhook for user {user.id}: {e}")
            return False


class SyncStatusManager:
    """Manages Invoice Ninja synchronization status for users"""
    
    @staticmethod
    def update_sync_status(user, status, increment_attempts=True):
        """
        Updates the Invoice Ninja sync status for a user.
        
        Args:
            user: The Django User instance
            status: New sync status ('pending', 'synced', 'failed', 'retry')
            increment_attempts: Whether to increment the sync attempts counter
        """
        user.invoiceninja_sync_status = status
        user.invoiceninja_last_sync_attempt = timezone.now()
        
        if increment_attempts:
            user.invoiceninja_sync_attempts += 1
            
        user.save(update_fields=['invoiceninja_sync_status', 'invoiceninja_last_sync_attempt', 'invoiceninja_sync_attempts'])
        
        logger.info(f"Updated sync status for user {user.id}: {status} (attempt #{user.invoiceninja_sync_attempts})")
    
    @staticmethod
    def mark_sync_success(user, client_id):
        """
        Marks a user as successfully synced with Invoice Ninja.
        
        Args:
            user: The Django User instance
            client_id: The Invoice Ninja client ID
        """
        user.invoiceninja_client_id = client_id
        user.invoiceninja_sync_status = 'synced'
        user.invoiceninja_last_sync_attempt = timezone.now()
        
        user.save(update_fields=['invoiceninja_client_id', 'invoiceninja_sync_status', 'invoiceninja_last_sync_attempt'])
        
        logger.info(f"Marked user {user.id} as successfully synced with Invoice Ninja client ID: {client_id}")
    
    @staticmethod
    def get_users_pending_sync():
        """
        Returns users that need to be synced with Invoice Ninja.
        
        Returns:
            QuerySet of User instances that need syncing
        """
        return User.objects.filter(
            invoiceninja_sync_status__in=['pending', 'retry', 'failed'],
            invoiceninja_sync_attempts__lt=getattr(settings, 'INVOICE_NINJA_MAX_SYNC_ATTEMPTS', 3)
        )
    
    @staticmethod
    def get_users_sync_failed():
        """
        Returns users whose sync has permanently failed.
        
        Returns:
            QuerySet of User instances with failed sync
        """
        return User.objects.filter(
            invoiceninja_sync_status='failed',
            invoiceninja_sync_attempts__gte=getattr(settings, 'INVOICE_NINJA_MAX_SYNC_ATTEMPTS', 3)
        )


def process_user_for_invoice_ninja_sync(user):
    """
    Main function to process a user for Invoice Ninja synchronization.
    
    This function is called by Django signals when a user is created or updated.
    
    Args:
        user: The Django User instance to sync
        
    Returns:
        bool: True if processing was initiated successfully, False otherwise
    """
    try:
        # Skip if user is already synced
        if user.invoiceninja_sync_status == 'synced' and user.invoiceninja_client_id:
            logger.info(f"User {user.id} already synced with Invoice Ninja. Skipping.")
            return True
        
        # Skip if max attempts reached
        max_attempts = getattr(settings, 'INVOICE_NINJA_MAX_SYNC_ATTEMPTS', 3)
        if user.invoiceninja_sync_attempts >= max_attempts:
            logger.warning(f"User {user.id} has reached max sync attempts ({max_attempts}). Skipping.")
            return False
        
        # Update status to pending
        SyncStatusManager.update_sync_status(user, 'pending')
        
        # Send webhook
        webhook_sender = WebhookSender()
        success = webhook_sender.send_user_created_webhook(user)
        
        if not success:
            SyncStatusManager.update_sync_status(user, 'failed')
            return False
            
        logger.info(f"Successfully initiated Invoice Ninja sync for user {user.id}")
        return True
        
    except Exception as e:
        logger.error(f"Error processing user {user.id} for Invoice Ninja sync: {e}")
        SyncStatusManager.update_sync_status(user, 'failed')
        return False
