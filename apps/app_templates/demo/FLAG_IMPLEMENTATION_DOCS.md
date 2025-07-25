# Country Flag Display Implementation

## Overview
This implementation adds country flag display functionality to the flight search form. When a user selects an origin airport, the system will display both the currency code and the country flag.

## How It Works

### Backend (views.py)
1. **Enhanced AJAX Response**: The `get_currency_code_ajax` function now returns:
   - `currency_code`: The currency for the selected country (e.g., "DZD")
   - `country_code`: The lowercase country code for flag file naming (e.g., "dz")
   - `country_name`: The full country name (e.g., "Algeria")
   - `iata_code`: The airport code for debugging

2. **Country Code Processing**: 
   - Gets the country code from airport data
   - Converts to lowercase for flag file naming consistency
   - Uses pycountry to get the full country name

### Frontend (JavaScript)
1. **Flag Loading**: 
   - Constructs flag path: `/static/flags/{country_code}.svg`
   - Tests if flag exists before displaying
   - Shows flag only if it loads successfully
   - Handles errors gracefully

2. **Display Logic**:
   - Shows currency: "Currency: DZD (Algeria)"
   - Displays flag alongside currency information
   - Hides flag if not found or on error

### Styling (CSS)
1. **Flag Appearance**:
   - 28x20px flag size with rounded corners
   - Shadow and border effects
   - Hover animations
   - Responsive design

2. **Container Styling**:
   - Semi-transparent background with blur effect
   - Proper spacing and alignment
   - Smooth transitions

## Supported Countries
The system works with any country that has:
1. An airport in the airports database
2. A corresponding flag file in `/static/flags/{country_code}.svg`

## Example Usage
1. User types "ALG" in origin field
2. System detects Algeria (DZ country code)
3. Backend returns: 
   ```json
   {
     "currency_code": "DZD",
     "country_code": "dz", 
     "country_name": "Algeria"
   }
   ```
4. Frontend displays: 🇩🇿 "Currency: DZD (Algeria)"

## Debug Features
- Console logging for troubleshooting
- Graceful error handling
- Flag existence testing
- Comprehensive debug output in backend

## File Structure
```
partials/
├── flight_search_scripts.html (JavaScript logic)
├── flight_search_styles.html (CSS styling)
├── flight_search_form.html (HTML structure)
└── flight_search_tutorial.html (User guidance)

apps/
└── views.py (Backend AJAX handler)

static/flags/
└── *.svg (Country flag files)
```

## Testing
The implementation includes extensive logging and error handling to ensure reliable operation across all supported countries.
