# views.py
from django.shortcuts import render
def set_language(request):
    next_url = request.POST.get('next', request.GET.get('next'))
    if not next_url or not url_has_allowed_host_and_scheme(url=next_url, allowed_hosts={request.get_host()}):
        next_url = request.META.get('HTTP_REFERER', '/')

    response = redirect(next_url)
    lang_code = request.POST.get('language', request.GET.get('language'))
    if lang_code and lang_code in dict(settings.LANGUAGES).keys():
        if hasattr(request, 'session'):
            request.session['django_language'] = lang_code
        response.set_cookie(settings.LANGUAGE_COOKIE_NAME, lang_code)
        activate(lang_code)  # Activate the language immediately for the current request

    # Debugging output
    print(f"Session language: {request.session.get('django_language')}")
    print(f"Cookie language: {request.COOKIES.get(settings.LANGUAGE_COOKIE_NAME)}")
    print(f"Current language: {get_language()}")

    return response

def dashboard_view(request):
    return render(request, 'topblogs/dashboard.html')

def estetik_view(request):
    return render(request, 'topblogs/estetik.html')

def ht_view(request):
    return render(request, 'topblogs/HT.html')

def internal_surgeries_view(request):
    return render(request, 'topblogs/InternalSurgeries.html')

def tbindex_view(request):
    return render(request, 'topblogs/tbindex.html')

def whybeyond_view(request):
    return render(request, 'topblogs/whybeyond.html')

def whyturkey_view(request):
    return render(request, 'topblogs/whyturkey.html')
