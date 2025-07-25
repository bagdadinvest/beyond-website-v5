# referral_views.py

from django.shortcuts import render, redirect
from django.contrib.auth import login_required
from .forms import CustomUserCreationForm
from .referral_utils import generate_referral_code, handle_referral

def register(request):
    if request.method == 'POST':
        form = CustomUserCreationForm(request.POST)
        if form.is_valid():
            user = form.save(commit=False)
            referral_code = form.cleaned_data.get('referral_code')
            if referral_code and not handle_referral(user, referral_code):
                form.add_error('referral_code', 'Invalid referral code')
                return render(request, 'registration/register.html', {'form': form})
            user.referral_code = generate_referral_code()
            user.save()
            login(request, user)
            return redirect('home')
    else:
        form = CustomUserCreationForm()
    return render(request, 'registration/register.html', {'form': form})

@login_required
def generate_referral_code_view(request):
    user = request.user
    if not user.referral_code:
        user.referral_code = generate_referral_code()
        user.save()
    return JsonResponse({'referral_code': user.referral_code})
