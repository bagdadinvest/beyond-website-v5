from django import template

register = template.Library()

@register.filter
def remove_special_chars(value):
    """Removes special characters from phone numbers."""
    return ''.join(e for e in value if e.isalnum())

@register.simple_tag
def render_source_icon(source):
    """Renders the source icon."""
    icons = {
        'facebook': 'https://upload.wikimedia.org/wikipedia/commons/5/51/Facebook_f_logo_%282019%29.svg',
        'instagram': 'https://upload.wikimedia.org/wikipedia/commons/a/a5/Instagram_icon.png',
        'website': '/static/assets/img/logo-ct-dark.png'
    }
    return f'<img src="{icons.get(source, "/static/assets/img/default.png")}" alt="{source}" style="width:24px;">'

@register.simple_tag
def render_status_badge(status):
    """Renders a status badge with corresponding class."""
    badges = {
        'new': 'bg-primary',
        'contacted': 'bg-warning',
        'qualified': 'bg-success',
        'lost': 'bg-danger',
        'converted': 'bg-info'
    }
    return f'<span class="badge {badges.get(status, "bg-secondary")}">{status.title()}</span>'
