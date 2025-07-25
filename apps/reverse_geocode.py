from django.http import JsonResponse
from geopy.geocoders import Nominatim

def reverse_geocode(request):
    latitude = request.GET.get('latitude')
    longitude = request.GET.get('longitude')
    
    if latitude and longitude:
        geolocator = Nominatim(user_agent="geoapiExercises")
        location = geolocator.reverse(f"{latitude}, {longitude}")
        
        if location:
            address = location.raw.get('address', {})
            city = address.get('city', address.get('town', address.get('village', '')))
            return JsonResponse({'city': city}, status=200)
    
    return JsonResponse({'error': 'Invalid coordinates or unable to find location'}, status=400)
