from django.shortcuts import render
from django.http import HttpResponse

# Create your views here.

def index(request):
    """
    Main index view for the flights app
    This will be integrated with Amarius API
    """
    return render(request, 'flights/index.html', {
        'title': 'Flights Management',
        'message': 'Welcome to the Flights app! Ready for Amarius API integration.'
    })

# =============================================================================
# OLD CODE - COMMENTED OUT FOR REFERENCE
# Will be replaced with Amarius API integration logic
# =============================================================================

# from django.shortcuts import render, HttpResponse, HttpResponseRedirect
# from django.urls import reverse
# from django.http import JsonResponse
# from django.views.decorators.csrf import csrf_exempt
# from django.contrib.auth import authenticate, login, logout
# from datetime import datetime
# import math
# from .models import *
# from .pdf_utils import render_to_pdf, createticket
# from .constant import FEE

# OLD VIEWS WILL BE REPLACED WITH AMARIUS API LOGIC
# The views below were from the original flight booking system
# They will be replaced with new views that integrate with Amarius API

# def old_index(request):
#     # Original flight search logic
#     pass

# def old_login_view(request):
#     # Original login logic
#     pass

# def old_register_view(request):
#     # Original registration logic
#     pass

# Additional old views will be commented here when we migrate the logic
