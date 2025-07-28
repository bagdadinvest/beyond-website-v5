"""
Custom template filters for safe data access
"""
from django import template
from django.template.defaultfilters import stringfilter

register = template.Library()

@register.filter
def safe_get(value, default="N/A"):
    """
    Template filter to safely get values with fallback to default.
    Usage: {{ some_variable|safe_get:"Default Value" }}
    """
    if value is None or value == "" or value == []:
        return default
    return value

@register.filter  
def safe_attr(obj, attr_path):
    """
    Template filter to safely get nested attributes.
    Usage: {{ user|safe_attr:"profile.address.city" }}
    """
    try:
        if obj is None:
            return "N/A"
            
        attrs = attr_path.split('.')
        current = obj
        
        for attr in attrs:
            if hasattr(current, attr):
                current = getattr(current, attr)
            elif isinstance(current, dict) and attr in current:
                current = current[attr]
            else:
                return "N/A"
                
        return current if current not in [None, "", []] else "N/A"
    except:
        return "N/A"

@register.filter
def safe_dict_get(dictionary, key):
    """
    Template filter to safely get dictionary values.
    Usage: {{ flight_data|safe_dict_get:"price" }}
    """
    try:
        if isinstance(dictionary, dict):
            value = dictionary.get(key, "N/A")
            return value if value not in [None, "", []] else "N/A"
        return "N/A"
    except:
        return "N/A"

@register.filter
def fallback(value, default="N/A"):
    """
    Template filter that returns default if value is falsy.
    Usage: {{ variable|fallback:"Default Value" }}
    """
    return value if value else default
