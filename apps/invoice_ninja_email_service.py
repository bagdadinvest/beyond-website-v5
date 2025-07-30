"""
Modal notification utilities for Invoice Ninja integration

This module provides modal notification functionality for notifying patients
about their Invoice Ninja dashboard access after treatment plan creation/sync.
No emails are sent from Django - only modal notifications are triggered.
"""

import logging
from django.conf import settings
from .models import User

logger = logging.getLogger(__name__)


class InvoiceNinjaModalService:
    """Service class for handling Invoice Ninja modal notifications"""
    
    @staticmethod
    def should_show_modal(user, treatment_plan=None):
        """
        Check if Invoice Ninja dashboard modal should be shown to user
        
        Args:
            user: User instance (patient)
            treatment_plan: TreatmentPlan instance (optional)
            
        Returns:
            bool: True if modal should be shown, False otherwise
        """
        # Check if user has Invoice Ninja client ID (sync is complete)
        if not user.invoiceninja_client_id or user.invoiceninja_sync_status != 'synced':
            logger.info(f"User {user.email} not properly synced with Invoice Ninja. Modal not needed.")
            return False
            
        logger.info(f"User {user.email} is synced with Invoice Ninja. Modal should be shown.")
        return True


def should_trigger_invoice_ninja_modal(user, treatment_plan=None):
    """
    Check if Invoice Ninja modal notification should be triggered for a user
    
    This function should be called after:
    1. Treatment plan is created/synced successfully
    2. User's Invoice Ninja client account is ready
    
    Args:
        user: User instance
        treatment_plan: TreatmentPlan instance (optional)
        
    Returns:
        bool: True if modal should be shown
    """
    return InvoiceNinjaModalService.should_show_modal(
        user=user,
        treatment_plan=treatment_plan
    )
