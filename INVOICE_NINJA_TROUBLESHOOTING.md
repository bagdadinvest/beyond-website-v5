# Migration and Deployment Troubleshooting Guide

This guide helps resolve common issues when deploying the Invoice Ninja integration.

## Database Migration Issues

### Issue: `makemigrations` or `migrate` command hangs

**Symptoms**: Django management commands appear to freeze or hang indefinitely.

**Common Causes and Solutions**:

1. **Database Lock**: 
   ```bash
   # Check for locked processes
   sudo lsof | grep db.sqlite3
   
   # Kill any hanging processes
   sudo pkill -f "python.*manage.py"
   
   # Try migration again
   python manage.py migrate apps
   ```

2. **Large Transaction**:
   ```bash
   # Use timeout to prevent hanging
   timeout 60s python manage.py migrate apps
   
   # If timeout occurs, try smaller batches
   python manage.py migrate apps 0036  # Apply up to previous migration
   python manage.py migrate apps       # Apply the new migration
   ```

3. **Environment Issues**:
   ```bash
   # Clear Python cache
   find . -name "*.pyc" -delete
   find . -name "__pycache__" -type d -exec rm -rf {} +
   
   # Recreate virtual environment if needed
   deactivate
   rm -rf venv
   python -m venv venv
   source venv/bin/activate
   pip install -r requirements.txt
   ```

### Manual Migration Application

If automatic migration fails, apply changes manually:

```sql
-- For SQLite
ALTER TABLE apps_user ADD COLUMN invoiceninja_client_id VARCHAR(100) NULL;
ALTER TABLE apps_user ADD COLUMN invoiceninja_sync_status VARCHAR(20) DEFAULT 'pending';
ALTER TABLE apps_user ADD COLUMN invoiceninja_sync_attempts INTEGER DEFAULT 0;
ALTER TABLE apps_user ADD COLUMN invoiceninja_last_sync_attempt DATETIME NULL;

-- For PostgreSQL
ALTER TABLE apps_user ADD COLUMN invoiceninja_client_id VARCHAR(100) NULL;
ALTER TABLE apps_user ADD COLUMN invoiceninja_sync_status VARCHAR(20) DEFAULT 'pending';
ALTER TABLE apps_user ADD COLUMN invoiceninja_sync_attempts INTEGER DEFAULT 0;
ALTER TABLE apps_user ADD COLUMN invoiceninja_last_sync_attempt TIMESTAMP NULL;

-- Create indexes for performance
CREATE INDEX idx_apps_user_invoiceninja_client_id ON apps_user(invoiceninja_client_id);
CREATE INDEX idx_apps_user_invoiceninja_sync_status ON apps_user(invoiceninja_sync_status);
```

Then mark the migration as applied:
```bash
python manage.py migrate apps 0037 --fake
```

### Rollback Strategy

If you need to rollback the changes:

```bash
# Rollback to previous migration
python manage.py migrate apps 0036

# Remove the migration file
rm apps/migrations/0037_user_invoiceninja_client_id_and_more.py

# Regenerate if needed
python manage.py makemigrations apps
```

## Environment Configuration Issues

### Missing Environment Variables

Create a comprehensive `.env` file:

```bash
# Copy the example
cp .env.example .env

# Edit with your values
nano .env
```

Ensure all required variables are set:
```bash
# Check environment variables
python manage.py shell
>>> import os
>>> print("Webhook URL:", os.getenv('INVOICE_NINJA_WEBHOOK_URL'))
>>> print("Webhook Secret:", os.getenv('INVOICE_NINJA_WEBHOOK_SECRET'))
>>> exit()
```

### Django Settings Issues

Verify settings are properly loaded:

```python
# In Django shell
python manage.py shell
>>> from django.conf import settings
>>> print("Debug:", settings.DEBUG)
>>> print("Invoice Ninja settings:", {
...     k: v for k, v in settings.__dict__.items() 
...     if k.startswith('INVOICE_NINJA')
... })
>>> exit()
```

## Import and Dependency Issues

### Module Import Errors

If you see import errors for `invoice_ninja_utils`:

```bash
# Verify the file exists
ls -la apps/invoice_ninja_utils.py

# Check Python path
python manage.py shell
>>> import sys
>>> print('\n'.join(sys.path))
>>> exit()

# Test import manually
python manage.py shell
>>> from apps.invoice_ninja_utils import UserDataSerializer
>>> print("Import successful")
>>> exit()
```

### Signal Registration Issues

Verify signals are properly registered:

```python
# Check if signals are connected
python manage.py shell
>>> from django.db.models.signals import post_save
>>> from django.contrib.auth import get_user_model
>>> User = get_user_model()
>>> 
>>> # List all connected signals
>>> for receiver in post_save._live_receivers(sender=User):
...     print(f"Receiver: {receiver}")
>>> exit()
```

## Webhook and API Issues

### Webhook Delivery Problems

1. **Test webhook URL**:
   ```bash
   # Test basic connectivity
   curl -X POST https://your-webhook-url.com/test \
     -H "Content-Type: application/json" \
     -d '{"test": "data"}'
   ```

2. **Check Django logs**:
   ```bash
   # Enable verbose logging
   tail -f /var/log/django/debug.log
   
   # Or check Django development server output
   python manage.py runserver --verbosity=2
   ```

3. **Test with webhook.site**:
   ```bash
   # Temporarily use webhook.site for testing
   export INVOICE_NINJA_WEBHOOK_URL=https://webhook.site/your-unique-id
   
   # Create a test user and check webhook.site
   python manage.py shell
   >>> from django.contrib.auth import get_user_model
   >>> User = get_user_model()
   >>> user = User.objects.create_user(
   ...     username='test@example.com',
   ...     email='test@example.com',
   ...     password='testpass123'
   ... )
   >>> exit()
   ```

### Invoice Ninja API Issues

1. **Test API connectivity**:
   ```bash
   # Test API token
   curl -X GET "https://invoicing.co/api/v1/clients" \
     -H "X-API-TOKEN: your-api-token" \
     -H "X-Requested-With: XMLHttpRequest"
   ```

2. **Verify client creation**:
   ```bash
   # Test client creation manually
   curl -X POST "https://invoicing.co/api/v1/clients" \
     -H "X-API-TOKEN: your-api-token" \
     -H "X-Requested-With: XMLHttpRequest" \
     -H "Content-Type: application/json" \
     -d '{
       "name": "Test Client",
       "email": "test@example.com"
     }'
   ```

## External Service Issues

### n8n Workflow Problems

1. **Check n8n logs**:
   ```bash
   # If using Docker
   docker logs n8n-container-name
   
   # Check workflow execution logs in n8n interface
   ```

2. **Test webhook trigger**:
   - Use n8n's webhook test functionality
   - Send manual test payload
   - Check execution history

### FastAPI Service Issues

1. **Check service logs**:
   ```bash
   # If using the example FastAPI service
   uvicorn external_service_example:app --reload --log-level debug
   ```

2. **Test endpoints directly**:
   ```bash
   # Test health endpoint
   curl http://localhost:8000/health
   
   # Test webhook endpoint
   curl -X POST http://localhost:8000/webhook/user-created \
     -H "Content-Type: application/json" \
     -d '{"test": "data"}'
   ```

## Performance Issues

### Slow Webhook Delivery

1. **Check timeout settings**:
   ```python
   # In settings.py, adjust timeout
   INVOICE_NINJA_WEBHOOK_TIMEOUT = 30  # Increase if needed
   ```

2. **Monitor response times**:
   ```python
   # Add timing to webhook sender
   import time
   start_time = time.time()
   # ... webhook sending code ...
   print(f"Webhook took {time.time() - start_time:.2f} seconds")
   ```

### Database Performance

1. **Check query efficiency**:
   ```python
   # Enable query logging
   LOGGING = {
       'loggers': {
           'django.db.backends': {
               'level': 'DEBUG',
               'handlers': ['console'],
           }
       }
   }
   ```

2. **Add database indexes**:
   ```sql
   -- If not automatically created
   CREATE INDEX idx_user_invoiceninja_status ON apps_user(invoiceninja_sync_status);
   CREATE INDEX idx_user_invoiceninja_client_id ON apps_user(invoiceninja_client_id);
   ```

## Production Deployment Issues

### SSL/HTTPS Issues

1. **Verify SSL certificate**:
   ```bash
   curl -I https://your-domain.com/api/invoice-ninja/status/
   ```

2. **Check webhook URL scheme**:
   ```bash
   # Ensure webhook URL uses HTTPS in production
   echo $INVOICE_NINJA_WEBHOOK_URL
   ```

### Environment-Specific Issues

1. **Production vs Development settings**:
   ```python
   # Verify correct settings file
   python manage.py shell
   >>> from django.conf import settings
   >>> print("Settings module:", settings.SETTINGS_MODULE)
   >>> print("Debug mode:", settings.DEBUG)
   >>> exit()
   ```

2. **Static files and media**:
   ```bash
   # Collect static files
   python manage.py collectstatic --noinput
   
   # Check permissions
   ls -la staticfiles/
   ```

## Monitoring and Logging

### Enable Comprehensive Logging

Add to `settings.py`:

```python
LOGGING = {
    'version': 1,
    'disable_existing_loggers': False,
    'formatters': {
        'verbose': {
            'format': '{levelname} {asctime} {module} {process:d} {thread:d} {message}',
            'style': '{',
        },
    },
    'handlers': {
        'file': {
            'level': 'INFO',
            'class': 'logging.FileHandler',
            'filename': '/var/log/django/invoice_ninja.log',
            'formatter': 'verbose',
        },
        'console': {
            'level': 'DEBUG',
            'class': 'logging.StreamHandler',
            'formatter': 'verbose',
        },
    },
    'loggers': {
        'apps.invoice_ninja_utils': {
            'handlers': ['file', 'console'],
            'level': 'INFO',
            'propagate': True,
        },
        'apps.signals': {
            'handlers': ['file', 'console'],
            'level': 'INFO',
            'propagate': True,
        },
    },
}
```

### Health Check Endpoint

Create a health check for monitoring:

```python
# In apps/views.py
from django.http import JsonResponse
from django.contrib.auth import get_user_model
from .models import User

def invoice_ninja_health_check(request):
    """Health check endpoint for monitoring"""
    try:
        # Check database connectivity
        user_count = User.objects.count()
        
        # Check recent sync success rate
        from datetime import datetime, timedelta
        recent_syncs = User.objects.filter(
            invoiceninja_last_sync_attempt__gte=datetime.now() - timedelta(hours=24)
        )
        success_rate = recent_syncs.filter(
            invoiceninja_sync_status='synced'
        ).count() / max(recent_syncs.count(), 1)
        
        return JsonResponse({
            'status': 'healthy',
            'total_users': user_count,
            'success_rate_24h': success_rate,
            'timestamp': datetime.now().isoformat()
        })
    except Exception as e:
        return JsonResponse({
            'status': 'unhealthy',
            'error': str(e),
            'timestamp': datetime.now().isoformat()
        }, status=500)
```

## Emergency Procedures

### Stop All Sync Operations

```python
# Temporarily disable signals
python manage.py shell
>>> from django.db.models.signals import post_save
>>> from apps.signals import sync_user_with_invoice_ninja
>>> from django.contrib.auth import get_user_model
>>> User = get_user_model()
>>> post_save.disconnect(sync_user_with_invoice_ninja, sender=User)
>>> print("Sync signals disabled")
>>> exit()
```

### Mass Sync Status Reset

```python
# Reset failed syncs to pending
python manage.py shell
>>> from apps.models import User
>>> failed_users = User.objects.filter(invoiceninja_sync_status='failed')
>>> print(f"Resetting {failed_users.count()} failed syncs")
>>> failed_users.update(
...     invoiceninja_sync_status='pending',
...     invoiceninja_sync_attempts=0
... )
>>> exit()
```

### Bulk Data Export

```python
# Export sync status for analysis
python manage.py shell
>>> from apps.models import User
>>> import csv
>>> 
>>> with open('invoice_ninja_sync_status.csv', 'w', newline='') as csvfile:
...     writer = csv.writer(csvfile)
...     writer.writerow(['User ID', 'Email', 'Client ID', 'Status', 'Attempts', 'Last Attempt'])
...     for user in User.objects.all():
...         writer.writerow([
...             user.id,
...             user.email,
...             user.invoiceninja_client_id or 'None',
...             user.invoiceninja_sync_status,
...             user.invoiceninja_sync_attempts,
...             user.invoiceninja_last_sync_attempt or 'Never'
...         ])
>>> print("Export completed: invoice_ninja_sync_status.csv")
>>> exit()
```

## Getting Help

If issues persist:

1. **Check logs**: Always review Django logs, external service logs, and Invoice Ninja logs
2. **Test components**: Test each component individually (Django → webhook → external service → Invoice Ninja)
3. **Use debug mode**: Enable DEBUG=True in development to see detailed error messages
4. **Simplify**: Test with minimal data and basic webhook.site first
5. **Document**: Keep track of error messages and steps that led to the issue

Remember: The integration has multiple components, so isolate which component is failing before attempting fixes.
