#!/usr/bin/env python
"""
Test script to verify all URL namespace updates in flights templates
"""
import os
import re
import sys

# Add the project root to Python path
project_root = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, project_root)

def scan_template_files():
    """Scan all template files for URL patterns"""
    template_dir = '/root/Downloads/beyond-website-main/flights/templates'
    issues = []
    
    # Pattern to find URLs without flights: namespace
    url_pattern = r"{%\s*url\s+'([^']+)'\s*%}"
    
    for root, dirs, files in os.walk(template_dir):
        for file in files:
            if file.endswith('.html'):
                file_path = os.path.join(root, file)
                relative_path = file_path.replace('/root/Downloads/beyond-website-main/', '')
                
                try:
                    with open(file_path, 'r', encoding='utf-8') as f:
                        content = f.read()
                        
                    matches = re.findall(url_pattern, content)
                    
                    for match in matches:
                        if not match.startswith('flights:') and not match.startswith('app:'):
                            # Check if it's a generic URL that should stay as-is
                            if match not in ['logout', 'admin:', 'static']:
                                issues.append({
                                    'file': relative_path,
                                    'url': match,
                                    'line': None  # Could add line numbers if needed
                                })
                                
                except Exception as e:
                    print(f"Error reading {relative_path}: {e}")
    
    return issues

def main():
    print("Scanning flights templates for URL namespace issues...")
    print("=" * 60)
    
    issues = scan_template_files()
    
    if not issues:
        print("✅ All URLs properly namespaced with 'flights:' prefix!")
        print("\nSuccessfully updated all template URL references.")
    else:
        print(f"❌ Found {len(issues)} URL(s) that may need 'flights:' namespace:")
        print()
        
        current_file = None
        for issue in issues:
            if issue['file'] != current_file:
                print(f"\n📁 {issue['file']}:")
                current_file = issue['file']
            print(f"   - {{% url '{issue['url']}' %}}")
    
    print("\n" + "=" * 60)
    print("Scan complete!")

if __name__ == "__main__":
    main()
