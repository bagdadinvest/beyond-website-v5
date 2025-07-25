# -*- encoding: utf-8 -*-
from django.conf import settings
from django.conf.urls.static import static
from django.contrib import admin
from django.urls import path, include
from wagtail import urls as wagtail_urls
from wagtail.admin import urls as wagtailadmin_urls
from wagtail.documents import urls as wagtaildocs_urls
from apps.log_views import action_log_view  # Import the view from log_views.py
# project/urls.py

from django.conf.urls import handler500
from apps.errors import custom_error_view  # Correct import for custom error view
from rest_framework import permissions
from drf_yasg.views import get_schema_view
from drf_yasg import openapi
from editor import views
from django.conf.urls.i18n import i18n_patterns

# OpenAPI schema view
schema_view = get_schema_view(
    openapi.Info(
        title="Django API",
        default_version="v1",
        description="Interactive API Documentation for Django Shell API",
        terms_of_service="https://www.google.com/policies/terms/",
        contact=openapi.Contact(email="support@dentidelil-international.com"),
        license=openapi.License(name="MIT License"),
    ),
    public=True,
    permission_classes=(permissions.AllowAny,),
)

# Use the custom error view for all 500 errors
handler500 = custom_error_view

# Initialize `urlpatterns` before using `+=`
urlpatterns = [
    path('i18n/', include('django.conf.urls.i18n')),  # Language switching
]

# Wrap URLs with i18n_patterns
urlpatterns += i18n_patterns(
    path('editor/', views.editor_view, name='editor'),
    path('admin/doc/', include('django.contrib.admindocs.urls')),  # Add this line
    path('website/', include("websites.urls")),  # Websites app URLs
    path('admin/', admin.site.urls),
    path('baton/', include('baton.urls')),
    path('action-log/', action_log_view, name='action_log'),  # Moved outside the admin/ path
    path('accounts/', include('allauth.urls')),
    path("", include("apps.urls")),  # Main app URLs for 'apps'
    path('ckeditor/', include('ckeditor_uploader.urls')),
    path('rosetta/', include('rosetta.urls')),  # Rosetta for translation management
    path('cms/', include(wagtailadmin_urls)),  # Wagtail admin URLs
    path('documents/', include(wagtaildocs_urls)),  # Wagtail document management
    path('wag/', include(wagtail_urls)),  # Wagtail site pages
    path('topblogs/', include('topblogs.urls')),
    path('leads/', include('leads.urls')),
)

# Debug settings
if settings.DEBUG:
    import debug_toolbar
    urlpatterns += [
        path('__debug__/', include(debug_toolbar.urls)),  # Django Debug Toolbar
    ]
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
    urlpatterns += static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)

# API Docs
urlpatterns += [
    path("swagger/", schema_view.with_ui('swagger', cache_timeout=0), name='schema-swagger-ui'),
    path("redoc/", schema_view.with_ui('redoc', cache_timeout=0), name='schema-redoc'),
]
