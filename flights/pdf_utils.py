from django.http import HttpResponse
from django.template.loader import get_template
from xhtml2pdf import pisa
from io import BytesIO
import string
import random
from .models import Ticket, Passenger

def render_to_pdf(template_src, context_dict={}):
    """
    Utility function to render a template to PDF
    """
    template = get_template(template_src)
    html = template.render(context_dict)
    result = BytesIO()
    pdf = pisa.pisaDocument(BytesIO(html.encode("ISO-8859-1")), result)
    
    if not pdf.err:
        return HttpResponse(result.getvalue(), content_type='application/pdf')
    return None

def generate_ticket_reference():
    """ 
    Generate a unique ticket reference number
    """
    return ''.join(random.choices(string.ascii_uppercase + string.digits, k=6))

def createticket(user, passengers, passenger_count, flight, flight_date, seat_class, coupon=None, country_code="", email="", mobile=""):
    """
    Create a flight ticket with passengers
    """
    # Generate unique reference number
    ref_no = generate_ticket_reference()
    while Ticket.objects.filter(ref_no=ref_no).exists():
        ref_no = generate_ticket_reference()
    
    # Calculate fare based on seat class
    if seat_class.lower() == 'economy':
        flight_fare = flight.economy_fare
    elif seat_class.lower() == 'business':
        flight_fare = flight.business_fare
    elif seat_class.lower() == 'first':
        flight_fare = flight.first_fare
    else:
        flight_fare = flight.economy_fare
    
    # Calculate total fare
    total_fare = flight_fare * passenger_count
    other_charges = 100.0  # From constant.py
    
    # Apply coupon discount if provided
    coupon_discount = 0.0
    if coupon:
        # TODO: Implement coupon logic
        pass
    
    # Create ticket
    ticket = Ticket.objects.create(
        user=user,
        ref_no=ref_no,
        flight=flight,
        flight_ddate=flight_date,
        flight_adate=flight_date,  # TODO: Calculate arrival date
        flight_fare=flight_fare,
        other_charges=other_charges,
        coupon_used=coupon or "",
        coupon_discount=coupon_discount,
        total_fare=total_fare + other_charges - coupon_discount,
        seat_class=seat_class.lower(),
        mobile=mobile,
        email=email,
        status='PENDING'
    )
    
    # Add passengers to ticket
    for passenger_data in passengers:
        passenger = Passenger.objects.create(
            first_name=passenger_data.get('first_name', ''),
            last_name=passenger_data.get('last_name', ''),
            gender=passenger_data.get('gender', '')
        )
        ticket.passengers.add(passenger)
    
    return ticket
