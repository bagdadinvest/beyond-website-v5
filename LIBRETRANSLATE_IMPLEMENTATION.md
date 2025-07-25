# LibreTranslate Integration for Django Rosetta - Implementation Summary

## Overview
This implementation adds LibreTranslate support to Django Rosetta, allowing users to use their own self-hosted or public LibreTranslate instances for translation suggestions.

## Files Modified

### 1. `rosetta/conf/__init__.py`
- Added `LIBRETRANSLATE_URL` and `LIBRETRANSLATE_API_KEY` settings to the RosettaSettings class
- These settings allow users to configure their LibreTranslate server URL and optional API key

### 2. `rosetta/translate_utils.py`
- Modified `translate()` function to prioritize LibreTranslate when configured
- Added `translate_by_libretranslate()` function that handles:
  - URL normalization (automatically appends `/translate` if missing)
  - API key authentication via Bearer token
  - Language code normalization (strips locale suffixes)
  - Comprehensive error handling for various failure scenarios
  - Timeout handling (10 seconds)

### 3. `rosetta/views.py`
- Updated `TranslationFormView` to include `LIBRETRANSLATE_URL` in JavaScript settings
- Modified `server_auth_key` check to include LibreTranslate configuration
- Enhanced `translate_text()` view to support provider selection
- Added support for forcing LibreTranslate usage via `provider` parameter

### 4. `rosetta/templates/rosetta/form.html`
- Enhanced translation suggestion UI to include a provider dropdown
- Shows "LibreTranslate" option when `LIBRETRANSLATE_URL` is configured
- Wrapped controls in `.suggest-controls` div for better styling

### 5. `rosetta/static/admin/rosetta/js/rosetta.js`
- Enhanced suggestion click handler to:
  - Detect selected translation provider
  - Support direct LibreTranslate API calls from browser (with CORS handling)
  - Fall back to server-side translation when needed
  - Improved error handling and user feedback

### 6. `rosetta/static/admin/rosetta/css/rosetta.css`
- Added styling for the new translation provider controls
- Styled the dropdown and suggestion controls for better UX

### 7. `core/settings.py`
- Added LibreTranslate configuration variables
- Used environment variables for secure configuration

### 8. `rosetta/tests/tests.py`
- Added comprehensive test suite (`LibreTranslateTestCase`) covering:
  - Successful translation scenarios
  - API key authentication
  - Error handling (connection errors, API errors)
  - URL normalization
  - View integration

## Features Implemented

### ✅ Core Requirements Met
- [x] New "LibreTranslate" translation suggestion option in UI
- [x] Configurable via Django settings (`LIBRETRANSLATE_URL`, `LIBRETRANSLATE_API_KEY`)
- [x] POST requests to LibreTranslate API with correct format (`q`, `source`, `target`)
- [x] Fallback behavior when LibreTranslate is not configured
- [x] Clear configuration instructions and documentation

### ✅ Additional Features
- [x] Provider selection dropdown in UI
- [x] Direct browser-to-LibreTranslate API calls (when CORS allows)
- [x] Server-side fallback for CORS-restricted scenarios
- [x] Comprehensive error handling and user feedback
- [x] URL normalization (auto-appends `/translate`)
- [x] Bearer token authentication support
- [x] Language code normalization (handles locales)
- [x] Timeout handling (10 second timeout)
- [x] Multiple deployment examples (Docker, docker-compose, pip)
- [x] Test coverage for all major scenarios

## Configuration Examples

### Basic Configuration
```python
LIBRETRANSLATE_URL = 'http://localhost:5000/translate'
ROSETTA_ENABLE_TRANSLATION_SUGGESTIONS = True
```

### Secure Configuration with API Key
```python
LIBRETRANSLATE_URL = os.getenv('LIBRETRANSLATE_URL', 'http://localhost:5000/translate')
LIBRETRANSLATE_API_KEY = os.getenv('LIBRETRANSLATE_API_KEY', None)
ROSETTA_ENABLE_TRANSLATION_SUGGESTIONS = True
```

## Usage
1. Configure LibreTranslate server and Django settings
2. Open Django Rosetta interface
3. Navigate to any translation file
4. Click "suggest" button - user can choose between "Default" and "LibreTranslate" providers
5. Translation appears in textarea automatically

## Error Handling
The implementation handles various error scenarios gracefully:
- Connection failures
- Invalid API keys
- Unsupported language pairs
- Timeout issues
- Invalid JSON responses
- CORS restrictions

## Priority Order
When multiple translation services are configured, LibreTranslate takes priority, followed by DeepL, Azure, Google Cloud, and OpenAI.

## Documentation Files Created
- `LIBRETRANSLATE_SETUP.md`: Comprehensive setup and configuration guide
- `rosetta_libretranslate_example_settings.py`: Example Django settings configuration

This implementation provides a robust, user-friendly way to integrate LibreTranslate with Django Rosetta while maintaining compatibility with existing translation providers.
