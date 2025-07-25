import os
from django.core.management.base import BaseCommand

class Command(BaseCommand):
    help = 'Replace {% load static %} with {% load static i18n %} in HTML files or add {% load static i18n %} if not present. Use --undo to reverse the changes.'

    def add_arguments(self, parser):
        parser.add_argument(
            '--undo',
            action='store_true',
            help='Undo the changes by replacing {% load static i18n %} with {% load static %} or removing {% load static i18n %} if added.',
        )

    def handle(self, *args, **options):
        template_dir = os.path.join(os.path.dirname(__file__), '..', '..', 'templates')
        template_dir = os.path.abspath(template_dir)
        undo = options['undo']

        for subdir, _, files in os.walk(template_dir):
            for file in files:
                if file.endswith('.html'):
                    filepath = os.path.join(subdir, file)
                    with open(filepath, 'r', encoding='utf-8') as f:
                        content = f.read()

                    if undo:
                        content = self.undo_changes(content)
                    else:
                        content = self.process_file_content(content)

                    with open(filepath, 'w', encoding='utf-8') as f:
                        f.write(content)

    def process_file_content(self, content):
        # Check if '{% load static i18n %}' is already present
        if '{% load static i18n %}' in content:
            return content  # No changes needed

        # Check if '{% load static %}' is present anywhere in the content
        if '{% load static %}' in content:
            # Replace '{% load static %}' with '{% load static i18n %}'
            content = content.replace('{% load static %}', '{% load static i18n %}')
        else:
            # Add '{% load static i18n %}' after the {% extends %} tag if it exists
            if '{% extends ' in content:
                lines = content.split('\n')
                for i, line in enumerate(lines):
                    if line.strip().startswith('{% extends '):
                        lines.insert(i + 1, '{% load static i18n %}')
                        break
                content = '\n'.join(lines)
            else:
                # Add '{% load static i18n %}' at the top of the file
                content = '{% load static i18n %}\n' + content

        return content

    def undo_changes(self, content):
        # Check if '{% load static i18n %}' is present anywhere in the content
        if '{% load static i18n %}' in content:
            # Replace '{% load static i18n %}' with '{% load static %}'
            content = content.replace('{% load static i18n %}', '{% load static %}')
            # Remove '{% load static %}' from the top if it was added by this script
            if content.startswith('{% load static %}\n'):
                content = content[len('{% load static %}\n'):]
            else:
                # Remove the '{% load static %}' line that follows '{% extends %}'
                lines = content.split('\n')
                for i, line in enumerate(lines):
                    if line.strip() == '{% load static %}' and i > 0 and lines[i-1].strip().startswith('{% extends '):
                        del lines[i]
                        break
                content = '\n'.join(lines)
        return content
