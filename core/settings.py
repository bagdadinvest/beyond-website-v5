from __future__ import absolute_import, unicode_literals
import os
from pathlib import Path

# Load environment variables from .env file
try:
    from dotenv import load_dotenv
    load_dotenv()
except ImportError:
    pass

try:
    import psycopg2
except ImportError:
    psycopg2 = None


# Build paths inside the project like this: os.path.join(BASE_DIR, ...)
BASE_DIR = Path(__file__).resolve().parent.parent
CORE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

# Determine if we are in production or development
IS_PRODUCTION = os.getenv('IS_PRODUCTION', 'False').lower() in ('true', '1', 't')

# Security settings
SECRET_KEY = os.getenv('SECRET_KEY', 'your-default-secret-key')
DEBUG = True

MEDIA_URL = '/media/'
MEDIA_ROOT = os.path.join(BASE_DIR, 'media/')
EXPORT_ROOT = os.path.join(BASE_DIR, 'staticsite/')

# CKEditor settings
CKEDITOR_BASEPATH = "/media/ckeditor/ckeditor/"
CKEDITOR_UPLOAD_PATH = "uploads/"
CKEDITOR_CONFIGS = {
    'default': {
        'toolbar': 'full',
        'height': 300,
        'width': '100%',
    },
}

if IS_PRODUCTION:
    ALLOWED_HOSTS = ['app.delilclinic.com','delilclinic.com']
else:
    ALLOWED_HOSTS = ['app.delilclinic.com','localhost', '127.0.0.1','beyondclinic.online','beyondclinic.online','*']
    
    
CSRF_TRUSTED_ORIGINS = [
    ' http://app.delilclinic.com',
] if IS_PRODUCTION else [' http://app.delilclinic.com','http://localhost:8001']

try:
    # Try to connect to PostgreSQL to check if it's available
    if psycopg2 is not None:
        conn = psycopg2.connect(
            dbname='dentiboard',
            user='postgres',
            password='lofa12345',
            host='localhost',
            port='5432',
        )
        conn.close()
        DATABASES = {
            'default': {
                'ENGINE': 'django.db.backends.postgresql',
                'NAME': 'dentiboard',
                'USER': 'postgres',
                'PASSWORD': 'lofa12345',
                'HOST': 'localhost',
                'PORT': '5432',
            }
        }
    else:
        raise Exception("psycopg2 not available")
except Exception:
    DATABASES = {
        'default': {
            'ENGINE': 'django.db.backends.sqlite3',
            'NAME': os.path.join(BASE_DIR, 'db.sqlite3'),
        }
    }

# Application definition
INSTALLED_APPS = [
    'baton',
    'django.contrib.admin',
    'django.contrib.admindocs',  
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.sites',
    'allauth',
    'allauth.account',
    'allauth.socialaccount',
    'corsheaders',
    'django.contrib.staticfiles',
    'apps',
    'leads',
    'flights',
    'bootstrap3',
    'wagtail.contrib.forms',
    'wagtail.contrib.redirects',
    'wagtail.embeds',
    'wagtail.sites',
    'wagtail.users',
    'wagtail.snippets',
    'wagtail.documents',
    'wagtail.images',
    'wagtail.search',
    'wagtail.admin',
    'wagtail',  # This replaces wagtail.core
    'modelcluster',
    'taggit',
    'ckeditor',
    'ckeditor_uploader',
    'rosetta',
    'websites',
    'actstream',
    'import_export',
    'django_countries',
    'topblogs',  # Add this line
    'django_extensions',
    'rest_framework',
    'rest_framework.authtoken',  # Add Token Authentication
    'drf_yasg',  # Add OpenAPI support
    'export',
    'baton.autodiscover',

]

REST_FRAMEWORK = {
    'DEFAULT_AUTHENTICATION_CLASSES': [],
    'DEFAULT_PERMISSION_CLASSES': [
        'rest_framework.permissions.AllowAny',
    ],
}

WAGTAIL_SITE_NAME = "beyondboard"

X_FRAME_OPTIONS = 'ALLOW-FROM https://nxt.delilclinic.com'

if DEBUG:
    
    INSTALLED_APPS.append('livereload')
    INSTALLED_APPS.append('debug_toolbar')  # Add debug_toolbar when DEBUG is True

SITE_ID = 1

MIDDLEWARE = [
    'core.middleware.DisableCSRFCheckInDevelopment',  # Add this line
    'django.middleware.security.SecurityMiddleware',
    'whitenoise.middleware.WhiteNoiseMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.locale.LocaleMiddleware',
    'corsheaders.middleware.CorsMiddleware',
    'django.middleware.common.CommonMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'allauth.account.middleware.AccountMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
    'wagtail.contrib.redirects.middleware.RedirectMiddleware',
    'livereload.middleware.LiveReloadScript',
    'core.middleware.CustomDebugToolbarMiddleware',  # Add this line
    'core.middleware.SuperuserDebugMiddleware',  # Add this line

]


INTERNAL_IPS = [
    '127.0.0.1',
]

SESSION_ENGINE = 'django.contrib.sessions.backends.db'
LANGUAGE_COOKIE_NAME = 'django_language'

CORS_ORIGIN_ALLOW_ALL = True

ROOT_URLCONF = 'core.urls'
LOGIN_URL = '/'
LOGIN_REDIRECT_URL = "/"
LOGOUT_REDIRECT_URL = "/"


# Static files (CSS, JavaScript, Images)
STATIC_URL = '/static/'

# Directories where Django will search for additional static files apart from app-specific ones
STATICFILES_DIRS = [
    BASE_DIR / "static",                # Global static directory
    BASE_DIR / "apps/static",           # Static directory for the 'apps' app
    BASE_DIR / "websites/static",       # Static directory for the 'websites' app
    BASE_DIR / "topblogs/static",       # Static directory for the 'topblogs' app
]

# The directory where collectstatic will collect static files for production
STATIC_ROOT = BASE_DIR / "staticfiles"

WSGI_APPLICATION = 'core.wsgi.application'

# Password validation
AUTH_PASSWORD_VALIDATORS = [
    {
        'NAME': 'django.contrib.auth.password_validation.UserAttributeSimilarityValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.MinimumLengthValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.CommonPasswordValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.NumericPasswordValidator',
    },
]

LANGUAGE_CODE = 'en'  # Set English as the default language

LANGUAGES = [
    ('en', 'English'),    # English as the default language
    ('fr', 'French'),
    ('ar', 'Arabic'),
    ('tr', 'Turkish'),
    ('de', 'German'),
    ('es', 'Spanish'),
    ('pl', 'Polish'),
    ('pt', 'Portuguese'),
    ('hu', 'Hungarian'),
    ('ru', 'Russian'),
    ('bg', 'Bulgarian'),  # Bulgarian added
    ('it', 'Italian'),    # Italian added
]

ROSETTA_SHOW_AT_ADMIN_PANEL = True
ROSETTA_MESSAGES_PER_PAGE = 500

LIBRETRANSLATE_URL = 'http://185.246.86.108:5000/translate'
ROSETTA_ENABLE_TRANSLATION_SUGGESTIONS = True

TIME_ZONE = 'UTC'

USE_I18N = True

USE_L10N = True

USE_TZ = True

AUTH_USER_MODEL = 'apps.User'

BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

# Define paths relative to the project root (BASE_DIR)
WEBSITES_TEMPLATES_DIR = os.path.join(BASE_DIR, 'websites', 'site_templates')
APPS_TEMPLATES_DIR = os.path.join(BASE_DIR, 'apps', 'app_templates')
TOPBLOGS_TEMPLATES_DIR = os.path.join(BASE_DIR, 'topblogs', 'templates')

TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': [
            os.path.join(BASE_DIR, 'templates'),  # Main templates directory at project root
            os.path.join(BASE_DIR, 'templates', 'allauth'),  # allauth templates
            WEBSITES_TEMPLATES_DIR,  # Website-specific templates
            APPS_TEMPLATES_DIR,  # Apps templates directory
            TOPBLOGS_TEMPLATES_DIR,  # Top blogs templates directory
        ],
        'APP_DIRS': True,  # Allow Django to load templates from 'templates' folders in installed apps
        'OPTIONS': {
            'context_processors': [
                'django.template.context_processors.debug',
                'django.template.context_processors.request',
                'django.template.context_processors.i18n',
                'django.contrib.auth.context_processors.auth',
                'django.contrib.messages.context_processors.messages',
                'apps.context_processors.languages_context',
            ],
        },
    },
]

DEFAULT_AUTO_FIELD = 'django.db.models.BigAutoField'

# Localization
LOCALE_PATHS = [
    os.path.join(BASE_DIR, 'apps/locale'),
    os.path.join(BASE_DIR, 'apps/websites'),
    os.path.join(BASE_DIR, 'apps/topblogs'),

]

# Airtable and OpenAI API keys (Ensure these are secure and not exposed)
AIRTABLE_API_KEY = os.getenv('AIRTABLE_API_KEY')
AIRTABLE_BASE_ID = os.getenv('AIRTABLE_BASE_ID')
OPENAI_API_KEY = os.getenv('OPENAI_API_KEY')

# LibreTranslate Configuration for Rosetta
LIBRETRANSLATE_URL = os.getenv('LIBRETRANSLATE_URL', None)  # e.g., 'http://localhost:5000/translate'
LIBRETRANSLATE_API_KEY = os.getenv('LIBRETRANSLATE_API_KEY', None)  # Optional API key

ACCOUNT_EMAIL_REQUIRED = True
ACCOUNT_EMAIL_VERIFICATION = 'none'  # Disabled email verification to fix login issues
ACCOUNT_AUTHENTICATION_METHOD = 'email'
ACCOUNT_USERNAME_REQUIRED = False

# Authentication backends configuration
AUTHENTICATION_BACKENDS = [
    'apps.backends.EmailBackend',  # Custom email authentication backend
    'django.contrib.auth.backends.ModelBackend',  # Default Django backend
    'allauth.account.auth_backends.AuthenticationBackend',  # Allauth backend for email authentication
]
LOGIN_REDIRECT_URL = '/'
LOGOUT_REDIRECT_URL = '/'

# =============================================================================
# INVOICE NINJA INTEGRATION SETTINGS
# =============================================================================

# Invoice Ninja webhook configuration
INVOICE_NINJA_WEBHOOK_URL = os.getenv('INVOICE_NINJA_WEBHOOK_URL', None)
# Example: 'https://your-n8n-instance.com/webhook/invoice-ninja-sync'

# Webhook security (optional but recommended)
INVOICE_NINJA_WEBHOOK_SECRET = os.getenv('INVOICE_NINJA_WEBHOOK_SECRET', None)

# Webhook timeout in seconds
INVOICE_NINJA_WEBHOOK_TIMEOUT = int(os.getenv('INVOICE_NINJA_WEBHOOK_TIMEOUT', 30))

# Maximum number of sync attempts before marking as permanently failed
INVOICE_NINJA_MAX_SYNC_ATTEMPTS = int(os.getenv('INVOICE_NINJA_MAX_SYNC_ATTEMPTS', 3))

# Invoice Ninja API configuration (for future direct API integration)
INVOICE_NINJA_API_URL = os.getenv('INVOICE_NINJA_API_URL', None)
# Example: 'https://invoicing.co' or your self-hosted instance

INVOICE_NINJA_API_TOKEN = os.getenv('INVOICE_NINJA_API_TOKEN', None)
# Your Invoice Ninja API token

# Logging configuration for Invoice Ninja integration
LOGGING = {
    'version': 1,
    'disable_existing_loggers': False,
    'handlers': {
        'file': {
            'level': 'INFO',
            'class': 'logging.FileHandler',
            'filename': os.path.join(BASE_DIR, 'logs', 'invoice_ninja.log'),
        },
        'console': {
            'level': 'DEBUG',
            'class': 'logging.StreamHandler',
        },
    },
    'loggers': {
        'apps.invoice_ninja_utils': {
            'handlers': ['file', 'console'],
            'level': 'INFO',
            'propagate': True,
        },
        'apps.invoice_ninja_views': {
            'handlers': ['file', 'console'],
            'level': 'INFO',
            'propagate': True,
        },
        'apps.signals': {
            'handlers': ['file', 'console'],
            'level': 'INFO',
            'propagate': True,
        },
    },
}

# Create logs directory if it doesn't exist
import os
logs_dir = os.path.join(BASE_DIR, 'logs')
if not os.path.exists(logs_dir):
    os.makedirs(logs_dir)
# Email backend temporarily disabled to prevent login blocking
# EMAIL CONFIGURATION - COMPLETELY DISABLED TO PREVENT EMAIL FLOODING
EMAIL_BACKEND = 'django.core.mail.backends.dummy.EmailBackend'  # Changed to dummy backend to prevent any emails
# EMAIL_BACKEND = 'django.core.mail.backends.console.EmailBackend'  # Changed from SMTP to console
# EMAIL_BACKEND = 'django.core.mail.backends.smtp.EmailBackend'  # Original SMTP backend
EMAIL_HOST = 'smtp.gmail.com'
EMAIL_PORT = 587
EMAIL_USE_TLS = True
EMAIL_HOST_USER = 'info@delilclinic.com'  # Your Outlook email address
EMAIL_HOST_PASSWORD = 'hhev xbni rslj ugvg'
DEFAULT_FROM_EMAIL = 'info@delilclinic.com'


# Final corrected settings
WAGTAILADMIN_BASE_URL = 'http://app.delilclinic.com'

CKEDITOR_5_CONFIGS = {
    'default': {
        'toolbar': 'full',
        'height': 500,
        'width': '100%',
    }
}

COUNTRIES_FLAG_URL = 'flags/{code}.svg'

# Amadeus API Configuration
AMADEUS_CLIENT_ID = os.getenv('AMADEUS_CLIENT_ID', 'if4CO6oUQYKNCAr2lZsNympVLRM2AU1y')
AMADEUS_CLIENT_SECRET = os.getenv('AMADEUS_CLIENT_SECRET', 'pWbAzP4WTjPKqNn9')
