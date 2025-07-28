from django.shortcuts import render
from django.http import HttpResponse, JsonResponse
from django.contrib import messages
from django.contrib.auth.decorators import login_required
from django.conf import settings
import ast

# Amadeus API and related imports
from amadeus import Client, ResponseError, Location
import airportsdata
import pycountry

# Import our flight handling classes
from .flight import Flight
from .booking import Booking

# Initialize Amadeus client with settings
amadeus = Client(
    client_id=settings.AMADEUS_CLIENT_ID,
    client_secret=settings.AMADEUS_CLIENT_SECRET
)

# Load the airport data
airports = airportsdata.load('IATA')

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

def demo(request):
    """
    Main flight search view - migrated from apps.views.demo
    """
    currency_code = "EUR"  # Default currency code
    if request.method == "POST":
        # Retrieve data from the UI form
        origin = request.POST.get("Origin")
        destination = request.POST.get("Destination")
        departure_date = request.POST.get("Departuredate")
        return_date = request.POST.get("Returndate")

        # Get the wcurrency code
        currency_code = get_currency_code(origin)

        # Prepare URL parameters for search
        kwargs = {
            "originLocationCode": origin,
            "destinationLocationCode": destination,
            "departureDate": departure_date,
            "adults": 1,
            "currencyCode": currency_code  # Use PYCOUNTRY to get currency code
        }

        if return_date:
            kwargs["returnDate"] = return_date

        # Perform flight search based on previous inputs
        if origin and destination and departure_date:
            try:
                search_flights = amadeus.shopping.flight_offers_search.get(**kwargs)
            except ResponseError as error:
                messages.add_message(
                    request, messages.ERROR, error.response.result["errors"][0]["detail"]
                )
                return render(request, "flights/demo/home.html", {})
            search_flights_returned = []
            response = ""
            for flight in search_flights.data:
                offer = Flight(flight).construct_flights()
                search_flights_returned.append(offer)
                response = zip(search_flights_returned, search_flights.data)

            return render(
                request,
                "flights/demo/results.html",
                {
                    "response": response,
                    "origin": origin,
                    "destination": destination,
                    "departureDate": departure_date,
                    "returnDate": return_date,
                    "currency_code": currency_code  # Add currency code to context
                },
            )
    return render(request, "flights/demo/home.html", {})

def get_currency_code(iata_code):
    """
    Get currency code for a given IATA airport code
    """
    print(f"Getting currency code for IATA: {iata_code}")  # Debugging statement
    airport = airports.get(iata_code)
    if airport:
        print(f"Airport data: {airport}")  # Debugging statement
        country_code = airport['country']
        country = pycountry.countries.get(alpha_2=country_code)
        if country:
            print(f"Country data: {country}")  # Debugging statement
            currency = pycountry.currencies.get(numeric=country.numeric)
            if currency:
                print(f"Currency data: {currency}")  # Debugging statement
                return currency.alpha_3
            else:
                print("Currency not found")  # Debugging statement
        else:
            print("Country not found")  # Debugging statement
    else:
        print("Airport not found")  # Debugging statement
    return "EUR"  # Default to eur  if currency cannot be determined

def get_currency_code_ajax(request):
    """
    AJAX view to get currency code and country information for airport
    """
    if request.headers.get('x-requested-with') == 'XMLHttpRequest':
        iata_code = request.GET.get("iata_code", "").strip().upper()
        print(f"Processing IATA code: {iata_code}")  # Debug
        
        airport = airports.get(iata_code)
        currency_code = get_currency_code(iata_code)
        
        # Get country code for flag display
        country_code = None
        country_name = None
        
        if airport and 'country' in airport:
            original_country_code = airport['country']
            country_code = original_country_code.lower()  # Convert to lowercase for flag file naming
            print(f"Country code from airport: {original_country_code} -> {country_code}")  # Debug
            
            country = pycountry.countries.get(alpha_2=original_country_code)
            if country:
                country_name = country.name
                print(f"Country name: {country_name}")  # Debug
            else:
                print(f"Country not found in pycountry for code: {original_country_code}")  # Debug
        else:
            print(f"Airport not found or missing country data for IATA: {iata_code}")  # Debug
        
        response_data = {
            "currency_code": currency_code,
            "country_code": country_code,
            "country_name": country_name,
            "iata_code": iata_code  # Include for debugging
        }
        
        print(f"Returning response: {response_data}")  # Debug
        return JsonResponse(response_data, safe=False)
    
    return JsonResponse({"error": "Invalid request"}, status=400)

def flight_time_view(request):
    """
    View function to render the flight time demo page.
    This displays an interactive 3D earth with flight path visualization.
    """
    return render(request, 'flights/flight-time.html')

def book_flight(request, flight):
    """
    Flight booking view - migrated from apps.views.book_flight
    """
    # Create a fake traveler profile for booking
    traveler = {
        "id": "1",
        "dateOfBirth": "1982-01-16",
        "name": {"firstName": "JORGE", "lastName": "GONZALES"},
        "gender": "MALE",
        "contact": {
            "emailAddress": "jorge.gonzales833@telefonica.es",
            "phones": [
                {
                    "deviceType": "MOBILE",
                    "countryCallingCode": "34",
                    "number": "480080076",
                }
            ],
        },
        "documents": [
            { 
                "documentType": "PASSPORT",
                "birthPlace": "Madrid",
                "issuanceLocation": "Madrid",
                "issuanceDate": "2015-04-14",
                "number": "00000000",
                "expiryDate": "2025-04-14",
                "issuanceCountry": "ES",
                "validityCountry": "ES",
                "nationality": "ES",
                "holder": True,
            }
        ],
    }
    # Use Flight Offers Price to confirm price and availability
    try:
        flight_price_confirmed = amadeus.shopping.flight_offers.pricing.post(
            ast.literal_eval(flight)
        ).data["flightOffers"]
    except (ResponseError, KeyError, AttributeError) as error:
        messages.add_message(request, messages.ERROR, error.response.body)
        return render(request, "flights/demo/book_flight.html", {})

    # Use Flight Create Orders to perform the booking
    try:
        flight_booking = amadeus.booking.flight_orders.post(
            flightOffers=flight_price_confirmed, travelers=[traveler]
        ).data
    except (ResponseError, KeyError, AttributeError) as error:
        messages.add_message(request, messages.ERROR, error.response.body)
        return render(request, "flights/demo/book_flight.html", {})

    # Return booking data to template
    booking = Booking(flight_booking).construct_booking()
    return render(request, "flights/demo/book_flight.html", {"booking": booking})

def origin_airport_search(request):
    """
    AJAX view for origin airport autocomplete search
    """
    term = request.GET.get("term", "").lower()
    if request.headers.get('x-requested-with') == 'XMLHttpRequest':
        matching_airports = [airport for code, airport in airports.items() if term in code.lower()]
        if not matching_airports:
            matching_airports = [airport for code, airport in airports.items() if term in airport["city"].lower()]
        if not matching_airports:
            matching_airports = [airport for code, airport in airports.items() if term in airport["name"].lower()]
        return JsonResponse(get_city_airport_list(matching_airports), safe=False)
    return JsonResponse({"error": "Invalid request"}, status=400)

def destination_airport_search(request):
    """
    AJAX view for destination airport autocomplete search
    """
    term = request.GET.get("term", "").lower()
    if request.headers.get('x-requested-with') == 'XMLHttpRequest':
        matching_airports = [airport for code, airport in airports.items() if term in code.lower()]
        if not matching_airports:
            matching_airports = [airport for code, airport in airports.items() if term in airport["city"].lower()]
        if not matching_airports:
            matching_airports = [airport for code, airport in airports.items() if term in airport["name"].lower()]
        return JsonResponse(get_city_airport_list(matching_airports), safe=False)
    return JsonResponse({"error": "Invalid request"}, status=400)

def get_city_airport_list(data):
    """
    Helper function to format airport data for autocomplete
    """
    result = []
    for airport in data:
        result.append(f'{airport["iata"]}, {airport["name"]}')
    return result

# =============================================================================
# SIMPLE RENDER VIEWS FOR ORIGINAL FLIGHT TEMPLATES
# These are the views for the original flight booking system templates
# =============================================================================

def flight_index(request):
    """Original flight booking index page"""
    return render(request, 'flight/index.html', {
        'title': 'Flight Booking System',
        'page': 'index'
    })

def flight_search(request):
    """Flight search page"""
    return render(request, 'flight/search.html', {
        'title': 'Search Flights',
        'page': 'search'
    })

def flight_book(request):
    """Flight booking page"""
    return render(request, 'flight/book.html', {
        'title': 'Book Flight',
        'page': 'book'
    })

def flight_bookings(request):
    """Flight bookings management page"""
    return render(request, 'flight/bookings.html', {
        'title': 'My Bookings',
        'page': 'bookings'
    })

def flight_payment(request):
    """Flight payment page"""
    return render(request, 'flight/payment.html', {
        'title': 'Payment',
        'page': 'payment'
    })

def flight_payment_process(request):
    """Flight payment processing page"""
    return render(request, 'flight/payment_process.html', {
        'title': 'Processing Payment',
        'page': 'payment_process'
    })

def flight_ticket(request):
    """Flight ticket display page"""
    return render(request, 'flight/ticket.html', {
        'title': 'Flight Ticket',
        'page': 'ticket'
    })

def flight_login(request):
    """Flight login page"""
    return render(request, 'flight/login.html', {
        'title': 'Login',
        'page': 'login'
    })

def flight_register(request):
    """Flight registration page"""
    return render(request, 'flight/register.html', {
        'title': 'Register',
        'page': 'register'
    })

def flight_about(request):
    """Flight about page"""
    return render(request, 'flight/about.html', {
        'title': 'About Us',
        'page': 'about'
    })

def flight_contact(request):
    """Flight contact page"""
    return render(request, 'flight/contact.html', {
        'title': 'Contact Us',
        'page': 'contact'
    })

def flight_privacy_policy(request):
    """Flight privacy policy page"""
    return render(request, 'flight/privacy-policy.html', {
        'title': 'Privacy Policy',
        'page': 'privacy'
    })

def flight_terms(request):
    """Flight terms and conditions page"""
    return render(request, 'flight/terms.html', {
        'title': 'Terms & Conditions',
        'page': 'terms'
    })

def flight_time_original(request):
    """Original flight time page"""
    return render(request, 'flight/flight-time.html', {
        'title': 'Flight Time',
        'page': 'flight_time'
    })

# =============================================================================
# SIMPLE RENDER VIEWS FOR NEW THEME TEMPLATES  
# These are views for the "new" theme templates
# =============================================================================

def new_index(request):
    """
    Enhanced new theme index page with integrated flight search functionality
    Handles both GET and POST requests for flight search
    """
    from datetime import datetime, timedelta
    
    # Initialize context with default values
    context = {
        'title': 'CT Travel - Find Your Perfect Flight',
        'page': 'new_index',
        'origin': '',
        'destination': '',
        'depart_date': '',
        'return_date': '',
        'seat': 'economy',
        'trip_type': '1',  # Default to one-way
        'min_date': datetime.now().strftime('%Y-%m-%d'),
        'max_date': (datetime.now() + timedelta(days=365)).strftime('%Y-%m-%d'),
    }
    
    if request.method == "POST":
        print("=== NEW SETUP DEBUG: POST request received ===")
        print(f"Request method: {request.method}")
        print(f"Content type: {request.content_type}")
        print(f"POST data: {dict(request.POST)}")
        print(f"User: {request.user}")
        print(f"URL path: {request.path}")
        print(f"Request META: {request.META.get('CONTENT_TYPE', 'No content type')}")
        
        # Handle flight search form submission
        origin = request.POST.get("Origin", "")
        destination = request.POST.get("Destination", "")
        departure_date = request.POST.get("Departuredate", "")
        return_date = request.POST.get("Returndate", "")
        seat_class = request.POST.get("SeatClass", "economy")
        trip_type = request.POST.get("TripType", "1")
        
        print(f"=== NEW SETUP DEBUG: Form data extraction ===")
        print(f"Origin: '{origin}'")
        print(f"Destination: '{destination}'")
        print(f"Departure: '{departure_date}'")
        print(f"Return: '{return_date}'")
        print(f"Class: '{seat_class}'")
        print(f"Trip Type: '{trip_type}'")
        
        # Update context with form data
        context.update({
            'origin': origin,
            'destination': destination,
            'depart_date': departure_date,
            'return_date': return_date,
            'seat': seat_class,
            'trip_type': trip_type,
        })
        
        # Get the currency code for pricing
        currency_code = get_currency_code(origin) if origin else "EUR"
        print(f"=== NEW SETUP DEBUG: Currency code: {currency_code} ===")
        
        # Prepare parameters for Amadeus API search
        if origin and destination and departure_date:
            print(f"=== NEW SETUP DEBUG: Calling Amadeus API ===")
            kwargs = {
                "originLocationCode": origin,
                "destinationLocationCode": destination,
                "departureDate": departure_date,
                "adults": 1,
                "currencyCode": currency_code
            }

            if return_date and trip_type == "2":  # Round trip
                kwargs["returnDate"] = return_date
                
            print(f"=== NEW SETUP DEBUG: API parameters ===")
            print(f"kwargs: {kwargs}")
            print(f"Amadeus client: {amadeus}")
            print(f"Client ID: {amadeus.client_id[:8]}...")
            print(f"Client comparison - Same as old?: {amadeus.client_id == 'if4CO6oUQYKNCAr2lZsNympVLRM2AU1y'}")

            try:
                # Perform flight search using Amadeus API - EXACT REPLICATION FROM WORKING CODE
                print("=== NEW SETUP DEBUG: Making API call ===")
                print("Calling amadeus.shopping.flight_offers_search.get(**kwargs)")
                search_flights = amadeus.shopping.flight_offers_search.get(**kwargs)
                print(f"=== NEW SETUP DEBUG: API SUCCESS ===")
                print(f"Response type: {type(search_flights)}")
                print(f"Data length: {len(search_flights.data) if search_flights.data else 0}")
                
                search_flights_returned = []
                response = ""
                
                # Process flights exactly like in working apps/views.py
                print("=== NEW SETUP DEBUG: Processing flights ===")
                for i, flight in enumerate(search_flights.data):
                    print(f"Processing flight {i+1}")
                    offer = Flight(flight).construct_flights()
                    search_flights_returned.append(offer)
                    response = zip(search_flights_returned, search_flights.data)
                
                print(f"=== NEW SETUP DEBUG: Processed {len(search_flights_returned)} flight offers ===")
                
                # Update context with results - exactly like working version
                context.update({
                    'search_results': search_flights_returned,
                    'flights_data': search_flights.data,
                    'response': response,
                    'search_performed': True,
                    'currency_code': currency_code,
                    'origin': origin,
                    'destination': destination,
                    'departureDate': departure_date,
                    'returnDate': return_date,
                })
                print("=== NEW SETUP DEBUG: Context updated with results ===")
                
            except ResponseError as error:
                # Exact error handling replication from working apps/views.py
                print(f"=== NEW SETUP DEBUG: API ERROR ===")
                print(f"Error type: {type(error)}")
                print(f"Error: {error}")
                print(f"Error response: {error.response}")
                try:
                    error_message = error.response.result["errors"][0]["detail"]
                    print(f"Error detail: {error_message}")
                except:
                    print("Could not extract error detail")
                    error_message = str(error)
                print(f"=== NEW SETUP DEBUG: Adding error message ===")
                messages.add_message(request, messages.ERROR, error_message)
                return render(request, "new/index.html", context)
                
            except Exception as e:
                print(f"=== NEW SETUP DEBUG: General error ===")
                print(f"Error type: {type(e)}")
                print(f"Error: {str(e)}")
                messages.add_message(
                    request, 
                    messages.ERROR, 
                    f"An error occurred while searching for flights: {str(e)}"
                )
        else:
            print(f"=== NEW SETUP DEBUG: Missing required fields ===")
            print(f"Origin: '{origin}', Destination: '{destination}', Departure: '{departure_date}'")
    else:
        print("=== NEW SETUP DEBUG: GET request received ===")
    
    print("=== NEW SETUP DEBUG: Rendering new/index.html template ===")
    return render(request, 'new/index.html', context)

def new_about(request):
    """New theme about page"""
    return render(request, 'new/about.html', {
        'title': 'New Theme - About',
        'page': 'new_about'
    })

def new_contact(request):
    """New theme contact page"""
    return render(request, 'new/contact.html', {
        'title': 'New Theme - Contact',
        'page': 'new_contact'
    })

def new_services(request):
    """New theme services page"""
    return render(request, 'new/services.html', {
        'title': 'New Theme - Services',
        'page': 'new_services'
    })

def new_elements(request):
    """New theme elements page"""
    return render(request, 'new/elements.html', {
        'title': 'New Theme - Elements',
        'page': 'new_elements'
    })

def new_index_api(request):
    """New theme API index page"""
    return render(request, 'new/index api.html', {
        'title': 'New Theme - API Index',
        'page': 'new_index_api'
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
