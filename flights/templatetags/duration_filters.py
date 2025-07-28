# flights/templatetags/duration_filters.py
import re
from django import template

register = template.Library()

@register.filter(name='format_duration')
def format_duration(value):
    """
    Converts duration from ISO 8601 format (PT1H30M) to readable format
    """
    if not value:
        return ""
        
    pattern = re.compile(r'PT(?:(\d+)H)?(?:(\d+)M)?')
    match = pattern.match(value)
    if not match:
        return value
    
    hours, minutes = match.groups()
    hours = int(hours) if hours else 0
    minutes = int(minutes) if minutes else 0
    
    if hours and minutes:
        return f"{hours}h {minutes}m"
    elif hours:
        return f"{hours}h"
    elif minutes:
        return f"{minutes}m"
    else:
        return value
