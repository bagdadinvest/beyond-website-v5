import os
import re
from django.core.management.base import BaseCommand

class Command(BaseCommand):
    help = 'Add {% trans %} tags to text in HTML files'

    def handle(self, *args, **kwargs):
        template_dir = os.path.join(os.path.dirname(__file__), '..', '..', 'templates')
        template_dir = os.path.abspath(template_dir)
        for subdir, _, files in os.walk(template_dir):
            for file in files:
                if file.endswith('.html'):
                    filepath = os.path.join(subdir, file)
                    with open(filepath, 'r', encoding='utf-8') as f:
                        content = f.read()
                    content = self.add_trans_tags(content)
                    with open(filepath, 'w', encoding='utf-8') as f:
                        f.write(content)

    def add_trans_tags(self, content):
        # Regex to match text outside HTML tags and Django template tags
        text_re = re.compile(r'>([^<{%]+)<')
        django_tag_re = re.compile(r'{%.*?%}')
        variable_re = re.compile(r'{{.*?}}')
        js_comment_re = re.compile(r'//.*')
        
        # Function to add {% trans %} around text
        def replace_func(match):
            text = match.group(1).strip()
            if text and not django_tag_re.search(text) and not variable_re.search(text) and not js_comment_re.search(text):
                return f'>{{% trans "{text}" %}}<'
            return match.group(0)

        return text_re.sub(replace_func, content)
