# LibreTranslate Configuration for Django Rosetta

Django Rosetta now supports LibreTranslate as a translation service provider. LibreTranslate is a free and open-source machine translation API that can be self-hosted.

## Quick Setup

### 1. Install and Run LibreTranslate

You can run LibreTranslate in several ways:

#### Option A: Using Docker (Recommended)
```bash
# Run LibreTranslate with default settings
docker run -ti --rm -p 5000:5000 libretranslate/libretranslate

# Run with API key protection (recommended for production)
docker run -ti --rm -p 5000:5000 -e LT_API_KEYS=true libretranslate/libretranslate
```

#### Option B: Using pip
```bash
pip install libretranslate
libretranslate --host 0.0.0.0 --port 5000
```

#### Option C: Docker Compose
Create a `docker-compose.yml` file:
```yaml
version: '3.8'
services:
  libretranslate:
    image: libretranslate/libretranslate:latest
    ports:
      - "5000:5000"
    environment:
      - LT_API_KEYS=true
      - LT_API_KEYS_DB_PATH=/data/api_keys.db
    volumes:
      - libretranslate_data:/data
    restart: unless-stopped

volumes:
  libretranslate_data:
```

Then run: `docker-compose up -d`

### 2. Configure Django Settings

Add the following settings to your Django `settings.py` file:

```python
# LibreTranslate Configuration
LIBRETRANSLATE_URL = "http://localhost:5000/translate"  # Your LibreTranslate server URL
LIBRETRANSLATE_API_KEY = "your-api-key-here"  # Optional: only if you enabled API key protection

# Enable translation suggestions
ROSETTA_ENABLE_TRANSLATION_SUGGESTIONS = True
```

### 3. Environment Variables (Recommended)

For security, use environment variables:

```python
# In settings.py
import os

LIBRETRANSLATE_URL = os.getenv('LIBRETRANSLATE_URL', 'http://localhost:5000/translate')
LIBRETRANSLATE_API_KEY = os.getenv('LIBRETRANSLATE_API_KEY', None)
ROSETTA_ENABLE_TRANSLATION_SUGGESTIONS = True
```

Then in your `.env` file or environment:
```bash
LIBRETRANSLATE_URL=http://localhost:5000/translate
LIBRETRANSLATE_API_KEY=your-secret-api-key
```

## Configuration Options

### Required Settings

- `LIBRETRANSLATE_URL`: The URL of your LibreTranslate server
  - Example: `http://localhost:5000/translate`
  - Example: `https://libretranslate.example.com/translate`
  - Note: The `/translate` endpoint will be automatically appended if not present

### Optional Settings

- `LIBRETRANSLATE_API_KEY`: API key for authentication (if LibreTranslate is configured with API key protection)
- `ROSETTA_ENABLE_TRANSLATION_SUGGESTIONS`: Must be `True` to enable any translation suggestions

## Usage

1. Once configured, open Django Rosetta in your browser
2. Navigate to any translation file
3. For each message, you'll see a "suggest" button
4. If LibreTranslate is configured, you'll see a dropdown next to the suggest button with translation provider options:
   - **Default**: Uses the first available translation service (LibreTranslate, DeepL, OpenAI, etc.)
   - **LibreTranslate**: Forces the use of LibreTranslate

## API Key Management

If you're running LibreTranslate with API key protection:

1. Generate an API key:
```bash
# If running locally
curl -X POST "http://localhost:5000/create_api_key"

# Returns: {"api_key": "your-generated-key"}
```

2. Add the key to your Django settings as shown above.

## Troubleshooting

### Common Issues

1. **Connection Error**: "Could not connect to LibreTranslate server"
   - Ensure LibreTranslate is running on the specified URL
   - Check firewall and network settings
   - Verify the URL format (include protocol: http:// or https://)

2. **API Key Error**: "LibreTranslate API key is invalid or missing"
   - Verify the API key is correct
   - Ensure LibreTranslate is running with API key protection enabled
   - Check that the API key is properly set in Django settings

3. **CORS Error**: "Connection failed (check CORS)"
   - This typically happens when accessing LibreTranslate directly from the browser
   - Use the server-side translation option by selecting "Default" in the provider dropdown
   - Or configure LibreTranslate with proper CORS headers

4. **Language Not Supported**: "Bad request"
   - Verify that both source and target languages are supported by your LibreTranslate instance
   - Check LibreTranslate logs for more details

### Language Support

LibreTranslate supports many language pairs. To see available languages:
```bash
curl http://localhost:5000/languages
```

### Testing Your Setup

Test your LibreTranslate setup directly:
```bash
curl -X POST \
  http://localhost:5000/translate \
  -H 'Content-Type: application/json' \
  -d '{
    "q": "Hello world",
    "source": "en",
    "target": "es"
  }'
```

Expected response:
```json
{
  "translatedText": "Hola mundo"
}
```

## Production Deployment

For production use:

1. **Use HTTPS**: Deploy LibreTranslate behind a reverse proxy with SSL
2. **Enable API Keys**: Protect your instance with API key authentication
3. **Resource Limits**: Configure appropriate CPU/memory limits
4. **Monitoring**: Set up logging and monitoring for the LibreTranslate service

### Example Nginx Configuration

```nginx
server {
    listen 443 ssl;
    server_name libretranslate.example.com;
    
    ssl_certificate /path/to/certificate.pem;
    ssl_certificate_key /path/to/private.key;
    
    location / {
        proxy_pass http://localhost:5000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        
        # CORS headers if needed
        add_header 'Access-Control-Allow-Origin' 'https://yourdjangoapp.com';
        add_header 'Access-Control-Allow-Methods' 'GET, POST, OPTIONS';
        add_header 'Access-Control-Allow-Headers' 'Content-Type, Authorization';
    }
}
```

## Alternative Public Instances

If you don't want to self-host, you can use public LibreTranslate instances:

```python
# Example using a public instance
LIBRETRANSLATE_URL = "https://translate.astian.org/translate"
# Note: Public instances may have rate limits and require API keys
```

**Warning**: Be cautious with public instances for sensitive content. Always prefer self-hosted solutions for production applications.
