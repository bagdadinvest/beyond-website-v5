# Testing the Invoice Ninja Integration

This document provides comprehensive testing procedures for the Django-Invoice Ninja integration system.

## Prerequisites for Testing

1. **Django Environment**: Working Django application with the integration installed
2. **External Service**: n8n workflow or FastAPI service running
3. **Invoice Ninja Instance**: Access to Invoice Ninja with API token
4. **Test Environment**: Separate from production for safe testing

## Test Environment Setup

### 1. Configure Test Environment Variables

Create a test `.env` file:

```bash
# Test webhook endpoint (you can use webhook.site for initial testing)
INVOICE_NINJA_WEBHOOK_URL=https://webhook.site/your-unique-id

# Test secret
INVOICE_NINJA_WEBHOOK_SECRET=test-secret-123

# Reduced timeout for faster testing
INVOICE_NINJA_WEBHOOK_TIMEOUT=10

# Fewer attempts for testing
INVOICE_NINJA_MAX_SYNC_ATTEMPTS=2

# Test Invoice Ninja instance
INVOICE_NINJA_API_URL=https://invoicing.co
INVOICE_NINJA_API_TOKEN=your-test-api-token
```

### 2. Apply Database Migrations

```bash
python manage.py migrate apps
```

### 3. Create Test Admin User

```bash
python manage.py createsuperuser
```

## Testing Procedures

### Test 1: Basic User Creation Webhook

**Objective**: Verify that Django sends webhooks when users are created.

**Steps**:
1. Set `INVOICE_NINJA_WEBHOOK_URL` to `https://webhook.site/your-unique-id`
2. Create a new user via Django admin or signup form
3. Check webhook.site to see if webhook was received

**Expected Result**:
```json
{
  "event": "user.created",
  "timestamp": "2025-01-25T10:30:00Z",
  "data": {
    "django_user_id": 123,
    "username": "test@example.com",
    "email": "test@example.com",
    "first_name": "Test",
    "last_name": "User",
    // ... additional fields
  }
}
```

**Verification**:
- [ ] Webhook payload received
- [ ] All expected fields present
- [ ] User sync status set to 'pending'

### Test 2: External Service Integration

**Objective**: Test the complete flow with external service.

**Prerequisites**: FastAPI service running or n8n workflow active

**Steps**:
1. Configure webhook URL to point to your external service
2. Create a new user in Django
3. Check external service logs
4. Verify client creation in Invoice Ninja
5. Check Django user sync status

**Expected Results**:
- [ ] External service receives webhook
- [ ] Client created in Invoice Ninja with correct data
- [ ] Django user updated with client ID
- [ ] User sync status changed to 'synced'

### Test 3: Callback Endpoint Testing

**Objective**: Test Django callback endpoint directly.

**Steps**:
```bash
# Test successful callback
curl -X POST http://localhost:8000/api/invoice-ninja/client-created/ \
  -H "Content-Type: application/json" \
  -H "X-Webhook-Secret: test-secret-123" \
  -d '{
    "django_user_id": 123,
    "invoice_ninja_client_id": "client_abc123",
    "success": true,
    "message": "Client created successfully"
  }'

# Test failed callback
curl -X POST http://localhost:8000/api/invoice-ninja/client-created/ \
  -H "Content-Type: application/json" \
  -H "X-Webhook-Secret: test-secret-123" \
  -d '{
    "django_user_id": 123,
    "success": false,
    "message": "Email already exists",
    "retry": true
  }'
```

**Expected Results**:
- [ ] Successful callback updates user with client ID
- [ ] Failed callback updates sync status to 'retry' or 'failed'
- [ ] Invalid webhook secret returns 403 error

### Test 4: Management Commands Testing

**Objective**: Test retry and reporting functionality.

**Steps**:
```bash
# Create users with failed sync status for testing
python manage.py shell
>>> from apps.models import User
>>> user = User.objects.get(id=123)
>>> user.invoiceninja_sync_status = 'failed'
>>> user.invoiceninja_sync_attempts = 1
>>> user.save()
>>> exit()

# Test retry command
python manage.py retry_invoice_ninja_syncs --dry-run
python manage.py retry_invoice_ninja_syncs --user-id 123

# Test report command
python manage.py invoice_ninja_sync_report
python manage.py invoice_ninja_sync_report --status failed
```

**Expected Results**:
- [ ] Dry run shows what would be retried
- [ ] Retry command initiates new sync attempts
- [ ] Report shows accurate sync statistics

### Test 5: Error Handling

**Objective**: Test various error scenarios.

**Test Cases**:

1. **Invalid Webhook URL**:
   - Set invalid webhook URL
   - Create user
   - Verify sync status set to 'failed'

2. **External Service Timeout**:
   - Use slow external service
   - Create user
   - Verify timeout handling

3. **Invalid Invoice Ninja Data**:
   - Send invalid data to Invoice Ninja
   - Verify error handling and retry logic

4. **Webhook Secret Mismatch**:
   - Send callback with wrong secret
   - Verify 403 response

### Test 6: Admin Interface Testing

**Objective**: Verify admin interface integration.

**Steps**:
1. Access Django admin
2. Go to Users section
3. Filter by Invoice Ninja sync status
4. View user details with Invoice Ninja fields
5. Try to edit Invoice Ninja fields (should be read-only)

**Expected Results**:
- [ ] Invoice Ninja fields visible in user list
- [ ] Filtering by sync status works
- [ ] Fieldset properly organized
- [ ] Invoice Ninja fields are read-only

### Test 7: Bulk Operations

**Objective**: Test bulk sync functionality.

**Steps**:
1. Create multiple users without sync
2. Use bulk callback endpoint:
```bash
curl -X POST http://localhost:8000/api/invoice-ninja/bulk-sync/ \
  -H "Content-Type: application/json" \
  -H "X-Webhook-Secret: test-secret-123" \
  -d '{
    "batch_id": "test_batch_001",
    "results": [
      {
        "django_user_id": 123,
        "invoice_ninja_client_id": "client_123",
        "success": true
      },
      {
        "django_user_id": 124,
        "success": false,
        "error": "Email already exists"
      }
    ]
  }'
```

**Expected Results**:
- [ ] Multiple users updated correctly
- [ ] Success and failure cases handled properly

## Load Testing

### Test 8: Performance Under Load

**Objective**: Test system performance with high user creation rate.

**Setup**:
```python
# create_test_users.py
import os
import django
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'core.settings')
django.setup()

from django.contrib.auth import get_user_model
import time

User = get_user_model()

# Create 100 users quickly
start_time = time.time()
for i in range(100):
    User.objects.create_user(
        username=f'test_user_{i}@example.com',
        email=f'test_user_{i}@example.com',
        password='testpass123',
        first_name=f'Test{i}',
        last_name='User'
    )
end_time = time.time()

print(f"Created 100 users in {end_time - start_time:.2f} seconds")
```

**Metrics to Monitor**:
- [ ] Webhook send success rate
- [ ] Average response time
- [ ] Memory usage
- [ ] Database query count

## Test Data Cleanup

After testing, clean up test data:

```bash
# Delete test users
python manage.py shell
>>> from apps.models import User
>>> User.objects.filter(username__startswith='test_user_').delete()
>>> exit()

# Reset sync statuses if needed
python manage.py shell
>>> from apps.models import User
>>> User.objects.filter(invoiceninja_sync_status='pending').update(invoiceninja_sync_status='pending', invoiceninja_sync_attempts=0)
>>> exit()
```

## Common Test Issues and Solutions

### Issue: Webhooks not being sent
**Symptoms**: No webhook received at external service
**Solutions**:
- Check `INVOICE_NINJA_WEBHOOK_URL` setting
- Verify Django signal is properly connected
- Check Django logs for errors
- Test with webhook.site first

### Issue: External service not creating clients
**Symptoms**: Webhook received but no Invoice Ninja client created
**Solutions**:
- Check external service logs
- Verify Invoice Ninja API token
- Test Invoice Ninja API directly
- Check field mapping in external service

### Issue: Callbacks not working
**Symptoms**: External service works but Django user not updated
**Solutions**:
- Verify callback URL accessibility
- Check webhook secret configuration
- Test callback endpoint directly
- Review Django callback logs

### Issue: Users stuck in pending status
**Symptoms**: Many users with 'pending' sync status
**Solutions**:
- Check external service health
- Review webhook delivery logs
- Use retry management command
- Check for network connectivity issues

## Test Checklist

Before considering the integration ready for production:

### Functionality Tests
- [ ] User creation triggers webhook
- [ ] Webhook payload contains all required fields
- [ ] External service receives and processes webhook
- [ ] Invoice Ninja client created with correct data
- [ ] Django receives callback and updates user
- [ ] Error scenarios handled gracefully
- [ ] Retry logic works correctly
- [ ] Management commands function properly
- [ ] Admin interface integration works

### Security Tests
- [ ] Webhook secret verification works
- [ ] Invalid secrets rejected
- [ ] HTTPS used in production
- [ ] Sensitive data not logged
- [ ] API tokens properly secured

### Performance Tests
- [ ] Single user creation < 5 seconds
- [ ] Bulk operations handle 100+ users
- [ ] No memory leaks during load testing
- [ ] Database queries optimized
- [ ] Webhook timeouts configured appropriately

### Integration Tests
- [ ] Works with production Invoice Ninja instance
- [ ] Custom fields properly mapped
- [ ] Referral data correctly synced
- [ ] Medical information handled appropriately
- [ ] Emergency contact data included

### Monitoring and Logging
- [ ] All operations logged appropriately
- [ ] Error logging includes sufficient detail
- [ ] Success metrics trackable
- [ ] Failed sync notifications working

## Production Deployment Checklist

Before deploying to production:

1. **Environment Configuration**:
   - [ ] Production webhook URL configured
   - [ ] Strong webhook secret set
   - [ ] Production Invoice Ninja instance configured
   - [ ] SSL certificates valid

2. **Monitoring Setup**:
   - [ ] Log monitoring configured
   - [ ] Error alerting setup
   - [ ] Sync success rate monitoring
   - [ ] Performance metrics tracking

3. **Backup and Recovery**:
   - [ ] Database backup strategy
   - [ ] Rollback plan documented
   - [ ] Test data cleanup procedures

4. **Documentation**:
   - [ ] Operations manual updated
   - [ ] Troubleshooting guide available
   - [ ] Emergency contact information documented
