# referral_utils.py

import uuid
from django.contrib.auth import get_user_model
from django.urls import reverse
from .models import Referral  # Ensure Referral model is imported


User = get_user_model()

def generate_referral_code():
    while True:
        code = str(uuid.uuid4()).replace('-', '')[:10]
        if not User.objects.filter(referral_code=code).exists():
            return code

def handle_referral(user, referral_code):
    try:
        referrer = User.objects.get(referral_code=referral_code)
        user.referred_by = referrer.id

        # Check if the referral already exists
        existing_referral = Referral.objects.filter(referrer=referrer, referred=user, code=referral_code).exists()
        if not existing_referral:
            Referral.objects.create(referrer=referrer, referred=user, code=referral_code)

        return True
    except User.DoesNotExist:
        return False

def get_or_create_referral_code(user):
    if user.referral_code:
        return user.referral_code
    else:
        user.referral_code = generate_referral_code()
        user.save()
        return user.referral_code

def get_referral_link(user, request):
    referral_code = get_or_create_referral_code(user)
    referral_link = request.build_absolute_uri(reverse('signup') + f'?referral_code={referral_code}')
    return referral_link
