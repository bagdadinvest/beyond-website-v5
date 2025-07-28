from django.contrib.auth.backends import ModelBackend
from django.contrib.auth import get_user_model
from django.db import models

User = get_user_model()

class EmailBackend(ModelBackend):
    """
    Custom authentication backend that allows users to login using their email address.
    This backend tries email first, then falls back to username if email lookup fails.
    """
    
    def authenticate(self, request, username=None, password=None, **kwargs):
        if username is None or password is None:
            return None
            
        try:
            # Try to find user by email first
            user = User.objects.get(email=username)
            
            # Check if the password is correct and user is active
            if user.check_password(password) and self.user_can_authenticate(user):
                return user
        except User.DoesNotExist:
            # Try with username as fallback
            try:
                user = User.objects.get(username=username)
                if user.check_password(password) and self.user_can_authenticate(user):
                    return user
            except User.DoesNotExist:
                pass
        except User.MultipleObjectsReturned:
            # Handle case where multiple users have the same email (shouldn't happen but just in case)
            pass
        
        return None

    def get_user(self, user_id):
        try:
            user = User.objects.get(pk=user_id)
            return user if self.user_can_authenticate(user) else None
        except User.DoesNotExist:
            return None

    def user_can_authenticate(self, user):
        """
        Reject users with is_active=False. Custom user models that don't have
        an `is_active` field are allowed.
        """
        is_active = getattr(user, 'is_active', None)
        return is_active or is_active is None
