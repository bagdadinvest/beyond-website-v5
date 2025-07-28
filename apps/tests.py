from django.contrib.contenttypes.models import ContentType
from django.test import TestCase
from actstream.models import Action
from .models import User
from datetime import date
from django.dispatch import receiver
from django.db.models.signals import post_save


class UserProfileUpdateTestCase(TestCase):
    def setUp(self):
        # Create a test user for profile update tests
        self.user = User.objects.create_user(
            username='testuser',
            email='user@example.com',
            password='password123',
            date_of_birth=date(1990, 1, 1),  # Provide a date_of_birth
            phone_number='1234567890'
        )

    def test_user_profile_update_signal(self):
        # Update user profile (change phone number)
        self.user.phone_number = '0987654321'
        self.user.save()

        # Verify that the update action was logged
        content_type = ContentType.objects.get_for_model(self.user)
        update_action = Action.objects.filter(
            verb__icontains='updated profile',
            actor_content_type=content_type,
            actor_object_id=self.user.id
        )
        self.assertEqual(update_action.count(), 1)
        self.assertIn('Phone number changed to 0987654321', update_action.first().description)


# TEMPORARILY DISABLED TO PREVENT DUPLICATE SIGNAL PROCESSING DURING SIGNUP
# @receiver(post_save, sender=User)
def log_user_profile_update_test(sender, instance, created, **kwargs):
    """
    Test signal handler - DISABLED to prevent conflicts with main signal handler
    """
    print(f"[DEBUG] Test signal handler DISABLED for user {instance.id}")
    return
    
    if not created:
        changes = []
        if 'phone_number' in instance.get_dirty_fields():
            changes.append(f"Phone number changed to {instance.phone_number}")
        if changes:
            change_details = "; ".join(changes)
            Action.objects.create(
                actor=instance,
                verb='updated profile',
                description=change_details
            )
            print(f"[DEBUG] Action logged: {instance.username} updated profile")
