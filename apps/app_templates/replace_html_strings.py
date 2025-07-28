import os
import re
import glob

# Define a list of variations to replace
variations = [
    r"BeyondClinic",  # Exact match
    r"Beyond\s*Clinic",  # "Beyond Clinic" with possible spaces
    r"Beyond\s*Blog",  # For "Beyond Blog"
    # Add any other patterns you think might appear
]

# Replacement string
replacement = "Delil Turkiye  Medical Tourism "

# Function to replace the strings in files
def replace_in_file(file_path, variations, replacement):
    with open(file_path, 'r', encoding='utf-8') as file:
        content = file.read()
    
    # Replace each variation
    for pattern in variations:
        content = re.sub(pattern, replacement, content)
    
    # Write the updated content back to the file
    with open(file_path, 'w', encoding='utf-8') as file:
        file.write(content)
    print(f"Updated: {file_path}")

# Function to scan all HTML files and apply the replacement
def update_html_files(directory):
    # Search recursively for HTML files in the directory
    html_files = glob.glob(os.path.join(directory, '**', '*.html'), recursive=True)

    # Check if HTML files were found
    if not html_files:
        print(f"No HTML files found in directory: {directory}")
        return
    
    # Loop through and process each HTML file
    print(f"Found {len(html_files)} HTML files in directory: {directory}")
    for file_path in html_files:
        print(f"Processing file: {file_path}")
        replace_in_file(file_path, variations, replacement)

# Run the function in the desired directory
if __name__ == "__main__":
    directory = input("Enter the directory path to scan for HTML files: ")
    update_html_files(directory)
