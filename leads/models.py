from django.db import models
from django.conf import settings  # Correct AUTH_USER_MODEL usage
from django_countries.fields import CountryField


class Lead(models.Model):
    STATUS_CHOICES = [
        ('new', 'New'), 
        ('contacted', 'Contacted'), 
        ('qualified', 'Qualified'), 
        ('lost', 'Lost'), 
        ('converted', 'Converted')
    ]

    SOURCE_CHOICES = [
        ('ig', 'Instagram'),
        ('fb', 'Facebook'),
        ('website', 'Website')
    ]

    name = models.CharField(max_length=255, blank=True, null=True)
    email = models.EmailField(blank=True, null=True)
    phone = models.CharField(max_length=15, blank=True, null=True)
    source = models.CharField(max_length=50, choices=SOURCE_CHOICES, blank=True, null=True)
    message = models.TextField(blank=True, null=True)
    status = models.CharField(max_length=50, choices=STATUS_CHOICES, default='new', blank=True, null=True)
    country = CountryField(blank=True, null=True)
    created_at = models.DateTimeField(auto_now_add=True)
    last_updated = models.DateTimeField(auto_now=True)

    def __str__(self):
        return f"{self.name} ({self.source})"


class LeadHistory(models.Model):
    lead = models.ForeignKey('Lead', on_delete=models.CASCADE, related_name='history', blank=True, null=True)
    timestamp = models.DateTimeField(auto_now_add=True)
    action = models.CharField(max_length=255, blank=True, null=True)
    user = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.SET_NULL, null=True, blank=True)

    def __str__(self):
        return f"{self.lead.name if self.lead else 'Unknown'} - {self.action} by {self.user if self.user else 'Unknown'}"


class Note(models.Model):
    lead = models.ForeignKey('Lead', on_delete=models.CASCADE, related_name='notes', blank=True, null=True)
    user = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.SET_NULL, null=True, blank=True)
    content = models.TextField(blank=True, null=True)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"Note by {self.user if self.user else 'Unknown'} on {self.lead.name if self.lead else 'Unknown'}"
