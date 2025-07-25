# myapp/management/commands/import_templates.py

from django.core.management.base import BaseCommand
from apps.models import EmailTemplate

class Command(BaseCommand):
    help = 'Import email templates into the new model'

    def handle(self, *args, **kwargs):
        # Replace this with actual import logic
        # Example: Importing from a static file or database
        templates = [
            {'name': 'Welcome Email', 'subject': 'Welcome to our service!', 'body': 'Hello {username}, welcome to our service!'},
            {'name': 'Password Reset', 'subject': 'Password Reset Request', 'body': 'Click the link to reset your password: {reset_link}'},
        ]
        
        for template_data 
        in templates:
            EmailTemplate.objects.get_or_create(
                name=template_data['name'],
                defaults={
                    'subject': template_data['subject'],
                    'body': template_data['body']
                }
            )
        
        self.stdout.write(self.style.SUCCESS('Successfully imported templates'))
