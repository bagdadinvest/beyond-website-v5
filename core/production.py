import os
from urllib.parse import urlparse
from .settings import *  # noqa

# Configure the domain name using the environment variable
# that Azure automatically creates for us.
ALLOWED_HOSTS = ['www.dentidelil-international.com','172.213.217.121:443']
CSRF_TRUSTED_ORIGINS = ['https://www.dentidelil-international.com','localhost']

# WhiteNoise configuration
MIDDLEWARE = [
    'django.middleware.security.SecurityMiddleware',
    'whitenoise.middleware.WhiteNoiseMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.common.CommonMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
]

SESSION_ENGINE = "django.contrib.sessions.backends.cache"
STATICFILES_STORAGE = 'whitenoise.storage.CompressedManifestStaticFilesStorage'
STATIC_ROOT = os.path.join(BASE_DIR, 'staticfiles')

# Get the connection string from the environment variable
conn_str = os.environ.get('AZURE_POSTGRESQL_CONNECTIONSTRING', '')

# Parse the connection string
if conn_str:
    url = urlparse(conn_str)
    DATABASES = {
        'default': {
            'ENGINE': 'django.db.backends.postgresql',
            'NAME': url.path[1:],  # Skip the leading '/'
            'USER': url.username,
            'PASSWORD': url.password,
            'HOST': url.hostname,
            'PORT': url.port or '5432',  # Use default PostgreSQL port if not specified
        }
    }
else:
    # Fallback to default or empty configuration if the connection string is not set
    DATABASES = {
        'default': {
            'ENGINE': 'django.db.backends.postgresql',
            'NAME': '',
            'USER': '',
            'PASSWORD': '',
            'HOST': '',
            'PORT': '5432',
        }
    }

# Ensure that DEBUG is False in production
DEBUG = True

# Other production-specific settings can be added here
