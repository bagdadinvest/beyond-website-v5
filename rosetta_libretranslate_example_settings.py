# Example Django settings for LibreTranslate integration with Rosetta

# Add this to your Django settings.py file
import os  # Add this import at the top of your settings file

# =============================================================================
# ROSETTA CONFIGURATION
# =============================================================================

# Enable translation suggestions
ROSETTA_ENABLE_TRANSLATION_SUGGESTIONS = True

# =============================================================================
# LIBRETRANSLATE CONFIGURATION
# =============================================================================

# LibreTranslate server URL
# Examples:
# - Local development: "http://localhost:5000/translate"
# - Production server: "https://translate.yourcompany.com/translate"
# - Public instance: "https://translate.astian.org/translate"
LIBRETRANSLATE_URL = os.getenv('LIBRETRANSLATE_URL', 'http://localhost:5000/translate')

# Optional: API key for LibreTranslate (if server requires authentication)
LIBRETRANSLATE_API_KEY = os.getenv('LIBRETRANSLATE_API_KEY', None)

# =============================================================================
# ENVIRONMENT VARIABLES (.env file)
# =============================================================================
# Add these to your .env file for security:
#
# LIBRETRANSLATE_URL=http://localhost:5000/translate
# LIBRETRANSLATE_API_KEY=your-secret-api-key-here

# =============================================================================
# ALTERNATIVE TRANSLATION PROVIDERS
# =============================================================================
# You can still use other providers alongside LibreTranslate:

# DeepL
# DEEPL_AUTH_KEY = os.getenv('DEEPL_AUTH_KEY', None)

# OpenAI
# OPENAI_API_KEY = os.getenv('OPENAI_API_KEY', None)

# Google Cloud Translate
# GOOGLE_APPLICATION_CREDENTIALS_PATH = '/path/to/credentials.json'
# GOOGLE_PROJECT_ID = 'your-project-id'

# Azure Translator
# AZURE_CLIENT_SECRET = os.getenv('AZURE_CLIENT_SECRET', None)

# =============================================================================
# DOCKER COMPOSE EXAMPLE FOR LIBRETRANSLATE
# =============================================================================
# Create a docker-compose.yml file in your project root:

# version: '3.8'
# services:
#   libretranslate:
#     image: libretranslate/libretranslate:latest
#     ports:
#       - "5000:5000"
#     environment:
#       - LT_API_KEYS=true
#       - LT_API_KEYS_DB_PATH=/data/api_keys.db
#     volumes:
#       - libretranslate_data:/data
#     restart: unless-stopped
# 
# volumes:
#   libretranslate_data:

# Then run: docker-compose up -d
# And create an API key: curl -X POST "http://localhost:5000/create_api_key"
