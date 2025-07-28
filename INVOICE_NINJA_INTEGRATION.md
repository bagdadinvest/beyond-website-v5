# Django-Invoice Ninja User Synchronization Integration

## Overview

This integration automatically synchronizes Django users with Invoice Ninja clients when users sign up or update their information. The system uses webhooks to communicate with external services (such as n8n or FastAPI microservices) that handle the actual Invoice Ninja API communication.

## Architecture

```
┌─────────────────┐    ┌──────────────────┐    ┌─────────────────┐    ┌──────────────────┐
│    Django       │    │   External       │    │   Invoice       │    │    Django        │
│    User         │───▶│   Service        │───▶│   Ninja         │───▶│    Callback      │
│    Signup       │    │   (n8n/FastAPI)  │    │   API           │    │    API           │
└─────────────────┘    └──────────────────┘    └─────────────────┘    └──────────────────┘
                              │                                              │
                              ▼                                              ▼
                       ┌─────────────────┐                          ┌──────────────────┐
                       │   Webhook       │                          │   Update User    │
                       │   Payload       │                          │   with Client    │
                       │   with User     │                          │   ID             │
                       │   Data          │                          │                  │
                       └─────────────────┘                          └──────────────────┘
```

## Features

### ✅ Automatic User Synchronization
- Triggers on user creation via Django signals
- Sends comprehensive user data via webhook
- Tracks synchronization status and attempts
- Handles referral code and relationship tracking

### ✅ Robust Error Handling
- Maximum retry attempts configuration
- Failed sync tracking and reporting
- Comprehensive logging
- Manual retry capabilities

### ✅ Admin Interface Integration
- Invoice Ninja fields visible in Django admin
- Read-only fields for safety
- Sync status filtering and searching
- Organized fieldsets for better UX

### ✅ API Endpoints for External Services
- Callback endpoint for successful client creation
- Bulk synchronization support
- Sync status checking
- Manual retry endpoints

### ✅ Management Commands
- Retry failed synchronizations
- Generate sync status reports
- Export reports to CSV
- Bulk operations support

## Model Fields Added

The following fields have been added to the `User` model:

```python
# Invoice Ninja Integration Fields
invoiceninja_client_id = models.CharField(max_length=50, null=True, blank=True, unique=True)
invoiceninja_sync_status = models.CharField(max_length=20, choices=[...], default='pending')
invoiceninja_sync_attempts = models.PositiveIntegerField(default=0)
invoiceninja_last_sync_attempt = models.DateTimeField(null=True, blank=True)
```

### Sync Status Values:
- `pending`: Initial state, sync not yet attempted
- `synced`: Successfully synchronized with Invoice Ninja
- `failed`: Sync failed and will not retry automatically
- `retry`: Sync failed but will be retried

## Configuration

Add the following settings to your Django `settings.py`:

```python
# =============================================================================
# INVOICE NINJA INTEGRATION SETTINGS
# =============================================================================

# Webhook URL for external service (n8n, FastAPI, etc.)
INVOICE_NINJA_WEBHOOK_URL = os.getenv('INVOICE_NINJA_WEBHOOK_URL', None)
# Example: 'https://your-n8n-instance.com/webhook/invoice-ninja-sync'

# Webhook security secret (optional but recommended)
INVOICE_NINJA_WEBHOOK_SECRET = os.getenv('INVOICE_NINJA_WEBHOOK_SECRET', None)

# Webhook timeout in seconds
INVOICE_NINJA_WEBHOOK_TIMEOUT = int(os.getenv('INVOICE_NINJA_WEBHOOK_TIMEOUT', 30))

# Maximum number of sync attempts before marking as permanently failed
INVOICE_NINJA_MAX_SYNC_ATTEMPTS = int(os.getenv('INVOICE_NINJA_MAX_SYNC_ATTEMPTS', 3))

# Invoice Ninja API configuration (for future direct API integration)
INVOICE_NINJA_API_URL = os.getenv('INVOICE_NINJA_API_URL', None)
INVOICE_NINJA_API_TOKEN = os.getenv('INVOICE_NINJA_API_TOKEN', None)
```

### Environment Variables

Create a `.env` file or set the following environment variables:

```bash
# Required
INVOICE_NINJA_WEBHOOK_URL=https://your-webhook-endpoint.com/invoice-ninja-sync

# Optional but recommended
INVOICE_NINJA_WEBHOOK_SECRET=your-secret-key-here
INVOICE_NINJA_WEBHOOK_TIMEOUT=30
INVOICE_NINJA_MAX_SYNC_ATTEMPTS=3

# For future direct API integration
INVOICE_NINJA_API_URL=https://invoicing.co
INVOICE_NINJA_API_TOKEN=your-api-token
```

## Webhook Payload Structure

When a user is created or updated, Django sends a webhook with the following structure:

```json
{
  "event": "user.created",
  "timestamp": "2025-01-25T10:30:00Z",
  "data": {
    "django_user_id": 123,
    "username": "user@example.com",
    "email": "user@example.com",
    "first_name": "John",
    "last_name": "Doe",
    "full_name": "John Doe",
    "phone_number": "+1234567890",
    "date_of_birth": "1990-01-01",
    "nationality": "US",
    "nationality_name": "United States",
    "referral_code": "REF123",
    "referred_by": "FRIEND456",
    "date_joined": "2025-01-25T10:00:00Z",
    "is_active": true,
    "sync_timestamp": "2025-01-25T10:30:00Z",
    
    "custom_fields": {
      "referral_code": "REF123",
      "referred_by": "FRIEND456",
      "nationality": "US",
      "django_user_id": "123",
      "signup_date": "2025-01-25"
    },
    
    "emergency_contact_name": "Jane Doe",
    "emergency_contact_phone": "+1234567891",
    "emergency_contact_relationship": "Spouse",
    
    "medical_sex": "M",
    "medical_conditions": "None",
    "allergies": "None",
    "medications": "None",
    "insurance_policy": "POL123456",
    "insurance_company": "Health Corp"
  }
}
```

## API Endpoints

### Callback for Successful Client Creation
```http
POST /api/invoice-ninja/client-created/
Content-Type: application/json
X-Webhook-Secret: your-secret-key

{
  "django_user_id": 123,
  "invoice_ninja_client_id": "client_abc123",
  "success": true,
  "message": "Client created successfully",
  "timestamp": "2025-01-25T10:35:00Z"
}
```

### Callback for Failed Client Creation
```http
POST /api/invoice-ninja/client-created/
Content-Type: application/json

{
  "django_user_id": 123,
  "success": false,
  "message": "Email already exists in Invoice Ninja",
  "retry": true,
  "timestamp": "2025-01-25T10:35:00Z"
}
```

### Get Sync Status
```http
GET /api/invoice-ninja/sync-status/123/
```

Response:
```json
{
  "user_id": 123,
  "username": "user@example.com",
  "email": "user@example.com",
  "invoice_ninja_client_id": "client_abc123",
  "sync_status": "synced",
  "sync_attempts": 1,
  "last_sync_attempt": "2025-01-25T10:30:00Z",
  "is_synced": true
}
```

### Get Pending Users
```http
GET /api/invoice-ninja/pending-users/
```

### Retry Sync for User
```http
POST /api/invoice-ninja/retry-sync/123/
```

## Management Commands

### Retry Failed Syncs
```bash
# Retry all failed syncs
python manage.py retry_invoice_ninja_syncs

# Retry sync for specific user
python manage.py retry_invoice_ninja_syncs --user-id 123

# Dry run to see what would be retried
python manage.py retry_invoice_ninja_syncs --dry-run

# Force retry even for users who exceeded max attempts
python manage.py retry_invoice_ninja_syncs --force
```

### Generate Sync Status Report
```bash
# Generate console report
python manage.py invoice_ninja_sync_report

# Export to CSV
python manage.py invoice_ninja_sync_report --export-csv report.csv

# Filter by status
python manage.py invoice_ninja_sync_report --status failed

# Include detailed user information
python manage.py invoice_ninja_sync_report --include-details
```

## External Service Implementation

### n8n Workflow

Create an n8n workflow with the following structure:

1. **Webhook Trigger**: Receive Django webhook
2. **Function Node**: Transform Django data to Invoice Ninja format
3. **HTTP Request**: Create client in Invoice Ninja
4. **Function Node**: Prepare callback payload
5. **HTTP Request**: Send callback to Django

### Sample n8n Function Node (Transform Data):
```javascript
// Transform Django user data to Invoice Ninja client format
const userData = items[0].json.data;

return [
  {
    json: {
      name: userData.full_name,
      primary_contact: {
        first_name: userData.first_name,
        last_name: userData.last_name,
        email: userData.email,
        phone: userData.phone_number
      },
      custom_value1: userData.referral_code || '',
      custom_value2: userData.referred_by || '',
      custom_value3: userData.nationality || '',
      custom_value4: userData.django_user_id.toString(),
      private_notes: `Django User ID: ${userData.django_user_id}\nSignup Date: ${userData.signup_date}`
    }
  }
];
```

### FastAPI Implementation

```python
from fastapi import FastAPI, HTTPException
import httpx

app = FastAPI()

@app.post("/webhook/invoice-ninja-sync")
async def sync_user_to_invoice_ninja(payload: dict):
    user_data = payload["data"]
    
    # Transform to Invoice Ninja format
    client_data = {
        "name": user_data["full_name"],
        "primary_contact": {
            "first_name": user_data["first_name"],
            "last_name": user_data["last_name"],
            "email": user_data["email"],
            "phone": user_data.get("phone_number", "")
        },
        "custom_value1": user_data.get("referral_code", ""),
        "custom_value2": user_data.get("referred_by", ""),
        "custom_value3": user_data.get("nationality", ""),
        "custom_value4": str(user_data["django_user_id"])
    }
    
    # Create client in Invoice Ninja
    async with httpx.AsyncClient() as client:
        response = await client.post(
            f"{INVOICE_NINJA_URL}/api/v1/clients",
            headers={
                "Authorization": f"Bearer {INVOICE_NINJA_TOKEN}",
                "Content-Type": "application/json"
            },
            json=client_data
        )
        
        # Send callback to Django
        if response.status_code == 200:
            client_id = response.json()["data"]["id"]
            callback_payload = {
                "django_user_id": user_data["django_user_id"],
                "invoice_ninja_client_id": client_id,
                "success": True
            }
        else:
            callback_payload = {
                "django_user_id": user_data["django_user_id"],
                "success": False,
                "message": "Failed to create client",
                "retry": True
            }
        
        await client.post(
            f"{DJANGO_URL}/api/invoice-ninja/client-created/",
            json=callback_payload
        )
```

## Invoice Ninja Custom Field Configuration

To properly display the custom fields in Invoice Ninja:

1. Go to **Settings > Custom Fields**
2. Configure the following custom fields:

| Field | Label | Type |
|-------|-------|------|
| custom_value1 | Referral Code | Single Line Text |
| custom_value2 | Referred By | Single Line Text |
| custom_value3 | Nationality | Single Line Text |
| custom_value4 | Django User ID | Single Line Text |

## Monitoring and Troubleshooting

### Check Sync Status in Admin
1. Go to Django Admin → Users
2. Filter by "Invoice Ninja Sync Status"
3. Review failed syncs and retry as needed

### View Logs
```bash
tail -f logs/invoice_ninja.log
```

### Common Issues

**Issue**: Webhook not being sent
- Check `INVOICE_NINJA_WEBHOOK_URL` setting
- Verify network connectivity
- Check Django logs for errors

**Issue**: Callback not working
- Verify webhook secret configuration
- Check callback URL accessibility
- Review external service logs

**Issue**: Users stuck in "pending" status
- Run sync report: `python manage.py invoice_ninja_sync_report --status pending`
- Retry manually: `python manage.py retry_invoice_ninja_syncs`

## Future Enhancements

1. **Direct Invoice Ninja API Integration**: Bypass external services for simple setups
2. **Bidirectional Sync**: Update Django users when Invoice Ninja clients change
3. **Bulk Import**: Import existing Invoice Ninja clients to Django
4. **Advanced Custom Field Mapping**: More flexible field mapping configuration
5. **Sync Scheduling**: Periodic sync jobs for missed users

## Security Considerations

1. **Webhook Secrets**: Always use webhook secrets in production
2. **HTTPS Only**: Ensure all webhook URLs use HTTPS
3. **Rate Limiting**: Implement rate limiting on callback endpoints
4. **Data Validation**: Validate all incoming webhook data
5. **Logging**: Log all sync operations for audit trails

## Support and Maintenance

- Monitor sync success rates regularly
- Review failed syncs weekly
- Update external service configurations as needed
- Keep webhook secrets secure and rotate periodically
