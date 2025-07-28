# Flag Icons Directory

This directory contains SVG flag icons for countries of origin display in product cards and details.

## File Naming Convention
- Use ISO 3166-1 alpha-2 country codes (lowercase)
- Examples: `tr.svg` for Turkey, `de.svg` for Germany, `us.svg` for United States

## Current Flags Available
- `tr.svg` - Turkey
- `de.svg` - Germany  
- `ch.svg` - Switzerland
- `gb.svg` - United Kingdom
- `fr.svg` - France
- `it.svg` - Italy
- `us.svg` - United States
- `cn.svg` - China
- `jp.svg` - Japan
- `gr.svg` - Greece

## Usage
Flags are automatically loaded using the country code from the `TreatmentProduct.country_of_origin` field.

If a flag file doesn't exist, the system gracefully falls back to displaying the country code as a badge.

## Adding New Flags
1. Create an SVG file named with the country's 2-letter ISO code (lowercase)
2. Use a 24x16 viewBox for consistency
3. Keep file sizes small by using simple geometric shapes
4. Place the file in this directory
