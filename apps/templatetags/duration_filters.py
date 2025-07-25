# myapp/templatetags/duration_filters.py
import re
from django import template

register = template.Library()

@register.filter(name='format_duration')
def format_duration(value):
    pattern = re.compile(r'PT(?:(\d+)H)?(?:(\d+)M)?')
    match = pattern.match(value)
    if not match:
        return value
    hours, minutes = match.groups()
    hours = int(hours) if hours else 0
    minutes = int(minutes) if minutes else 0
    return f"{hours} hours {minutes} minutes"
