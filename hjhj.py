import re

input_file = "urls.txt"
output_file = "validated_urls.txt"

def validate_url(url):
    # Ensure the URL starts with a valid scheme
    if not re.match(r'^https?://', url):
        return f"http://{url.strip()}"
    return url.strip()

with open(input_file, "r") as infile, open(output_file, "w") as outfile:
    for line in infile:
        cleaned_url = validate_url(line)
        outfile.write(cleaned_url + "\n")

print(f"Validated URLs written to {output_file}")
