# myapp/views.py

from django.shortcuts import render
from django.conf import settings

def custom_error_view(request, exception=None):
    """
    Renders the custom error page based on the `DEBUG` setting.
    If `DEBUG` is True, the native Django debug screen will be used.
    Otherwise, it will render a custom template for normal users.
    """
    # If DEBUG is True, Django will show the native debug page, so we don't need to handle it here
    if settings.DEBUG:
        return None  # Returning None will let Django's native debug view take over
    else:
        # For non-debug mode, show a generic error page
        return render(request, 'errors/page-404.html', status=500)

def preview_error(request):
    """
    View to preview the custom error page template.
    This is for development purposes only and should not be included in production.
    """
    return render(request, 'errors/page-404.html', status=404)
