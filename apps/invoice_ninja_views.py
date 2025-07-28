"""
Invoice Ninja API Views

This module provides API endpoints for handling callbacks from Invoice Ninja
and external services that process Invoice Ninja client creation.

Author: Django-Invoice Ninja Integration Team
Created: 2025-01-25
"""

import json
import logging
from django.http import JsonResponse, HttpResponseBadRequest, HttpResponseNotFound
from django.views.decorators.csrf import csrf_exempt
from django.views.decorators.http import require_http_methods
from django.utils.decorators import method_decorator
from django.contrib.auth import get_user_model
from django.conf import settings
from django.utils import timezone
from django.core.exceptions import ValidationError

from .invoice_ninja_utils import SyncStatusManager

# Set up logging
logger = logging.getLogger(__name__)

User = get_user_model()


def verify_webhook_secret(request):
    """
    Verifies the webhook secret from the request headers.
    
    Args:
        request: Django request object
        
    Returns:
        bool: True if secret is valid or not configured, False otherwise
    """
    expected_secret = getattr(settings, 'INVOICE_NINJA_WEBHOOK_SECRET', None)
    
    if not expected_secret:
        # If no secret is configured, allow the request
        return True
    
    provided_secret = request.headers.get('X-Webhook-Secret', '')
    return provided_secret == expected_secret


@csrf_exempt
@require_http_methods(["POST"])
def invoice_ninja_client_created_callback(request):
    """
    API endpoint to receive callbacks when Invoice Ninja clients are created.
    
    This endpoint is called by external services (n8n, FastAPI, etc.) after
    they successfully create a client in Invoice Ninja.
    
    Expected payload:
    {
        "django_user_id": 123,
        "invoice_ninja_client_id": "client_abc123",
        "success": true,
        "message": "Client created successfully",
        "timestamp": "2025-01-25T10:30:00Z"
    }
    
    Returns:
        JsonResponse with success/error status
    """
    try:
        # Verify webhook secret
        if not verify_webhook_secret(request):
            logger.warning("Invalid webhook secret provided for Invoice Ninja callback")
            return JsonResponse({
                'success': False,
                'error': 'Invalid webhook secret'
            }, status=403)
        
        # Parse JSON payload
        try:
            payload = json.loads(request.body)
        except json.JSONDecodeError as e:
            logger.error(f"Invalid JSON payload in Invoice Ninja callback: {e}")
            return HttpResponseBadRequest("Invalid JSON payload")
        
        # Validate required fields
        required_fields = ['django_user_id', 'success']
        missing_fields = [field for field in required_fields if field not in payload]
        
        if missing_fields:
            logger.error(f"Missing required fields in Invoice Ninja callback: {missing_fields}")
            return HttpResponseBadRequest(f"Missing required fields: {', '.join(missing_fields)}")
        
        django_user_id = payload['django_user_id']
        success = payload['success']
        
        # Find the user
        try:
            user = User.objects.get(id=django_user_id)
        except User.DoesNotExist:
            logger.error(f"User with ID {django_user_id} not found for Invoice Ninja callback")
            return HttpResponseNotFound(f"User with ID {django_user_id} not found")
        
        # Process successful client creation
        if success:
            invoice_ninja_client_id = payload.get('invoice_ninja_client_id')
            
            if not invoice_ninja_client_id:
                logger.error(f"Missing invoice_ninja_client_id for successful callback for user {django_user_id}")
                return HttpResponseBadRequest("Missing invoice_ninja_client_id for successful operation")
            
            # Update user with Invoice Ninja client ID
            SyncStatusManager.mark_sync_success(user, invoice_ninja_client_id)
            
            logger.info(f"Successfully updated user {django_user_id} with Invoice Ninja client ID: {invoice_ninja_client_id}")
            
            return JsonResponse({
                'success': True,
                'message': f'User {django_user_id} successfully synced with Invoice Ninja',
                'client_id': invoice_ninja_client_id
            })
        
        else:
            # Handle failed client creation
            error_message = payload.get('message', 'Unknown error occurred')
            
            # Update sync status to failed or retry based on error
            should_retry = payload.get('retry', False)
            new_status = 'retry' if should_retry else 'failed'
            
            SyncStatusManager.update_sync_status(user, new_status)
            
            logger.warning(f"Invoice Ninja client creation failed for user {django_user_id}: {error_message}")
            
            return JsonResponse({
                'success': True,  # Request was processed successfully, even though sync failed
                'message': f'Sync failure recorded for user {django_user_id}',
                'error': error_message,
                'status': new_status
            })
    
    except Exception as e:
        logger.error(f"Unexpected error in Invoice Ninja callback: {e}")
        return JsonResponse({
            'success': False,
            'error': 'Internal server error'
        }, status=500)


@csrf_exempt
@require_http_methods(["POST"])
def invoice_ninja_bulk_sync_callback(request):
    """
    API endpoint to receive bulk sync callbacks from Invoice Ninja.
    
    This endpoint handles callbacks for multiple users synced in a batch operation.
    
    Expected payload:
    {
        "batch_id": "batch_abc123",
        "results": [
            {
                "django_user_id": 123,
                "invoice_ninja_client_id": "client_abc123",
                "success": true
            },
            {
                "django_user_id": 124,
                "success": false,
                "error": "Email already exists"
            }
        ],
        "timestamp": "2025-01-25T10:30:00Z"
    }
    
    Returns:
        JsonResponse with batch processing results
    """
    try:
        # Verify webhook secret
        if not verify_webhook_secret(request):
            logger.warning("Invalid webhook secret provided for Invoice Ninja bulk callback")
            return JsonResponse({
                'success': False,
                'error': 'Invalid webhook secret'
            }, status=403)
        
        # Parse JSON payload
        try:
            payload = json.loads(request.body)
        except json.JSONDecodeError as e:
            logger.error(f"Invalid JSON payload in Invoice Ninja bulk callback: {e}")
            return HttpResponseBadRequest("Invalid JSON payload")
        
        # Validate required fields
        if 'results' not in payload or not isinstance(payload['results'], list):
            return HttpResponseBadRequest("Missing or invalid 'results' field")
        
        batch_id = payload.get('batch_id', 'unknown')
        results = payload['results']
        
        processed_count = 0
        success_count = 0
        error_count = 0
        errors = []
        
        # Process each result
        for result in results:
            try:
                django_user_id = result.get('django_user_id')
                success = result.get('success', False)
                
                if not django_user_id:
                    errors.append("Missing django_user_id in result")
                    error_count += 1
                    continue
                
                # Find the user
                try:
                    user = User.objects.get(id=django_user_id)
                except User.DoesNotExist:
                    errors.append(f"User {django_user_id} not found")
                    error_count += 1
                    continue
                
                # Process result
                if success:
                    invoice_ninja_client_id = result.get('invoice_ninja_client_id')
                    
                    if not invoice_ninja_client_id:
                        errors.append(f"Missing client ID for user {django_user_id}")
                        SyncStatusManager.update_sync_status(user, 'failed')
                        error_count += 1
                        continue
                    
                    SyncStatusManager.mark_sync_success(user, invoice_ninja_client_id)
                    success_count += 1
                    
                else:
                    error_message = result.get('error', 'Unknown error')
                    should_retry = result.get('retry', False)
                    new_status = 'retry' if should_retry else 'failed'
                    
                    SyncStatusManager.update_sync_status(user, new_status)
                    errors.append(f"User {django_user_id}: {error_message}")
                    error_count += 1
                
                processed_count += 1
                
            except Exception as e:
                errors.append(f"Error processing user {result.get('django_user_id', 'unknown')}: {str(e)}")
                error_count += 1
        
        logger.info(f"Processed bulk Invoice Ninja callback batch {batch_id}: {success_count} success, {error_count} errors")
        
        return JsonResponse({
            'success': True,
            'message': f'Processed batch {batch_id}',
            'processed_count': processed_count,
            'success_count': success_count,
            'error_count': error_count,
            'errors': errors
        })
    
    except Exception as e:
        logger.error(f"Unexpected error in Invoice Ninja bulk callback: {e}")
        return JsonResponse({
            'success': False,
            'error': 'Internal server error'
        }, status=500)


@csrf_exempt
@require_http_methods(["GET"])
def invoice_ninja_sync_status(request, user_id):
    """
    API endpoint to get the Invoice Ninja sync status for a specific user.
    
    Args:
        user_id: Django user ID
        
    Returns:
        JsonResponse with user's sync status
    """
    try:
        user = User.objects.get(id=user_id)
    except User.DoesNotExist:
        return HttpResponseNotFound(f"User with ID {user_id} not found")
    
    return JsonResponse({
        'user_id': user.id,
        'username': user.username,
        'email': user.email,
        'invoice_ninja_client_id': user.invoiceninja_client_id,
        'sync_status': user.invoiceninja_sync_status,
        'sync_attempts': user.invoiceninja_sync_attempts,
        'last_sync_attempt': user.invoiceninja_last_sync_attempt.isoformat() if user.invoiceninja_last_sync_attempt else None,
        'is_synced': bool(user.invoiceninja_client_id and user.invoiceninja_sync_status == 'synced')
    })


@csrf_exempt
@require_http_methods(["GET"])
def invoice_ninja_pending_users(request):
    """
    API endpoint to get a list of users pending Invoice Ninja synchronization.
    
    Returns:
        JsonResponse with list of users that need to be synced
    """
    try:
        pending_users = SyncStatusManager.get_users_pending_sync()
        
        users_data = []
        for user in pending_users:
            users_data.append({
                'user_id': user.id,
                'username': user.username,
                'email': user.email,
                'sync_status': user.invoiceninja_sync_status,
                'sync_attempts': user.invoiceninja_sync_attempts,
                'last_sync_attempt': user.invoiceninja_last_sync_attempt.isoformat() if user.invoiceninja_last_sync_attempt else None,
            })
        
        return JsonResponse({
            'success': True,
            'count': len(users_data),
            'users': users_data
        })
    
    except Exception as e:
        logger.error(f"Error fetching pending users: {e}")
        return JsonResponse({
            'success': False,
            'error': 'Internal server error'
        }, status=500)


@csrf_exempt
@require_http_methods(["POST"])
def invoice_ninja_retry_sync(request, user_id):
    """
    API endpoint to manually retry Invoice Ninja synchronization for a specific user.
    
    Args:
        user_id: Django user ID
        
    Returns:
        JsonResponse with retry operation result
    """
    try:
        user = User.objects.get(id=user_id)
    except User.DoesNotExist:
        return HttpResponseNotFound(f"User with ID {user_id} not found")
    
    # Check if user is already synced
    if user.invoiceninja_sync_status == 'synced' and user.invoiceninja_client_id:
        return JsonResponse({
            'success': False,
            'message': f'User {user_id} is already synced',
            'client_id': user.invoiceninja_client_id
        })
    
    # Check max attempts
    max_attempts = getattr(settings, 'INVOICE_NINJA_MAX_SYNC_ATTEMPTS', 3)
    if user.invoiceninja_sync_attempts >= max_attempts:
        return JsonResponse({
            'success': False,
            'message': f'User {user_id} has reached maximum sync attempts ({max_attempts})'
        })
    
    try:
        # Import here to avoid circular imports
        from .invoice_ninja_utils import process_user_for_invoice_ninja_sync
        
        success = process_user_for_invoice_ninja_sync(user)
        
        if success:
            return JsonResponse({
                'success': True,
                'message': f'Retry sync initiated for user {user_id}',
                'sync_attempts': user.invoiceninja_sync_attempts
            })
        else:
            return JsonResponse({
                'success': False,
                'message': f'Failed to initiate retry sync for user {user_id}'
            })
    
    except Exception as e:
        logger.error(f"Error retrying sync for user {user_id}: {e}")
        return JsonResponse({
            'success': False,
            'error': 'Internal server error'
        }, status=500)
