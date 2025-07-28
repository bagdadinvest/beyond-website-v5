from django.urls import path
from . import views

app_name = 'flights'

urlpatterns = [
    # Main flights app URLs
    path('', views.index, name='index'),
    
    # Migrated URLs from apps/urls.py (Amadeus API integration)
    path('demo/', views.demo, name='demo'),
    path('flight-time/', views.flight_time_view, name='flight_time'),
    path('book_flight/<str:flight>/', views.book_flight, name='book_flight'),
    path('origin_airport_search/', views.origin_airport_search, name='origin_airport_search'),
    path('destination_airport_search/', views.destination_airport_search, name='destination_airport_search'),
    path('get_currency_code/', views.get_currency_code_ajax, name='get_currency_code'),
    
    # =============================================================================
    # ORIGINAL FLIGHT BOOKING SYSTEM TEMPLATES (flight/ directory)
    # =============================================================================
    path('original/', views.flight_index, name='flight_index'),
    path('original/search/', views.flight_search, name='flight_search'),
    path('original/book/', views.flight_book, name='flight_book'),
    path('original/bookings/', views.flight_bookings, name='flight_bookings'),
    path('original/payment/', views.flight_payment, name='flight_payment'),
    path('original/payment-process/', views.flight_payment_process, name='flight_payment_process'),
    path('original/ticket/', views.flight_ticket, name='flight_ticket'),
    path('original/login/', views.flight_login, name='flight_login'),
    path('original/register/', views.flight_register, name='flight_register'),
    path('original/about/', views.flight_about, name='flight_about'),
    path('original/contact/', views.flight_contact, name='flight_contact'),
    path('original/privacy-policy/', views.flight_privacy_policy, name='flight_privacy_policy'),
    path('original/terms/', views.flight_terms, name='flight_terms'),
    path('original/flight-time/', views.flight_time_original, name='flight_time_original'),
    
    # =============================================================================
    # NEW THEME TEMPLATES (new/ directory) - Enhanced with integrated functionality
    # =============================================================================
    path('new/', views.new_index, name='new_index'),
    path('new/search/', views.new_index, name='new_index_search'),  # Same view handles search
    path('new/about/', views.new_about, name='new_about'),
    path('new/contact/', views.new_contact, name='new_contact'),
    path('new/services/', views.new_services, name='new_services'),
    path('new/elements/', views.new_elements, name='new_elements'),
    path('new/index-api/', views.new_index_api, name='new_index_api'),
]

# =============================================================================
# OLD URLs - COMMENTED OUT FOR REFERENCE
# These will be replaced with new Amarius API-based URLs
# =============================================================================

# urlpatterns = [
#     path("", views.index, name="index"),
#     path("login", views.login_view, name="login"),
#     path("logout", views.logout_view, name="logout"),
#     path("register", views.register_view, name="register"),
#     path("query/places/<str:q>", views.query, name="query"),
#     path("flight", views.flight, name="flight"),
#     path("review", views.review, name="review"),
#     path("flight/ticket/book", views.book, name="book"),
#     path("flight/ticket/payment", views.payment, name="payment"),
#     path('flight/ticket/api/<str:ref>', views.ticket_data, name="ticketdata"),
#     path('flight/ticket/print',views.get_ticket, name="getticket"),
#     path('flight/bookings', views.bookings, name="bookings"),
#     path('flight/ticket/cancel', views.cancel_ticket, name="cancelticket"),
#     path('flight/ticket/resume', views.resume_booking, name="resumebooking"),
#     path('contact', views.contact, name="contact"),
#     path('privacy-policy', views.privacy_policy, name="privacypolicy"),
#     path('terms-and-conditions', views.terms_and_conditions, name="termsandconditions"),
#     path('about-us', views.about_us, name="aboutus"),
#     path('flight-time', views.flighttime, name='flighttime'),
# ]
