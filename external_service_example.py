"""
Example External Service Implementation for Invoice Ninja Integration

This FastAPI service acts as a middleware between Django and Invoice Ninja,
handling the webhook from Django and creating clients in Invoice Ninja.

Installation:
    pip install fastapi uvicorn httpx python-dotenv

Usage:
    uvicorn invoice_ninja_service:app --host 0.0.0.0 --port 8001

Environment Variables:
    INVOICE_NINJA_URL=https://invoicing.co
    INVOICE_NINJA_TOKEN=your-api-token
    DJANGO_CALLBACK_URL=https://your-django-site.com/api/invoice-ninja/client-created/
    WEBHOOK_SECRET=your-secret-key
"""

import os
import asyncio
import logging
from datetime import datetime
from typing import Dict, Any, Optional

import httpx
from fastapi import FastAPI, HTTPException, Request, Depends
from fastapi.security import HTTPBearer
from pydantic import BaseModel, Field
from dotenv import load_dotenv

# Load environment variables
load_dotenv()

# Configuration
INVOICE_NINJA_URL = os.getenv("INVOICE_NINJA_URL", "https://invoicing.co")
INVOICE_NINJA_TOKEN = os.getenv("INVOICE_NINJA_TOKEN")
DJANGO_CALLBACK_URL = os.getenv("DJANGO_CALLBACK_URL")
WEBHOOK_SECRET = os.getenv("WEBHOOK_SECRET")

if not INVOICE_NINJA_TOKEN:
    raise ValueError("INVOICE_NINJA_TOKEN environment variable is required")

if not DJANGO_CALLBACK_URL:
    raise ValueError("DJANGO_CALLBACK_URL environment variable is required")

# Setup logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

# FastAPI app
app = FastAPI(
    title="Invoice Ninja Integration Service",
    description="Middleware service for Django-Invoice Ninja user synchronization",
    version="1.0.0"
)

security = HTTPBearer()

# Request/Response models
class UserData(BaseModel):
    django_user_id: int
    username: str
    email: str
    first_name: str
    last_name: str
    full_name: str
    phone_number: Optional[str] = None
    date_of_birth: Optional[str] = None
    nationality: Optional[str] = None
    nationality_name: Optional[str] = None
    referral_code: Optional[str] = None
    referred_by: Optional[str] = None
    date_joined: str
    is_active: bool
    sync_timestamp: str
    custom_fields: Dict[str, Any] = {}
    
    # Optional fields
    emergency_contact_name: Optional[str] = None
    emergency_contact_phone: Optional[str] = None
    emergency_contact_relationship: Optional[str] = None
    medical_sex: Optional[str] = None
    medical_conditions: Optional[str] = None
    allergies: Optional[str] = None
    medications: Optional[str] = None
    insurance_policy: Optional[str] = None
    insurance_company: Optional[str] = None

class WebhookPayload(BaseModel):
    event: str
    timestamp: str
    data: UserData

class InvoiceNinjaClient(BaseModel):
    name: str
    primary_contact: Dict[str, Any]
    custom_value1: str = ""
    custom_value2: str = ""
    custom_value3: str = ""
    custom_value4: str = ""
    private_notes: str = ""
    public_notes: str = ""

class CallbackPayload(BaseModel):
    django_user_id: int
    success: bool
    invoice_ninja_client_id: Optional[str] = None
    message: str = ""
    retry: bool = False
    timestamp: str = Field(default_factory=lambda: datetime.utcnow().isoformat())

# Dependency for webhook secret verification
async def verify_webhook_secret(request: Request):
    if WEBHOOK_SECRET:
        provided_secret = request.headers.get("X-Webhook-Secret")
        if provided_secret != WEBHOOK_SECRET:
            raise HTTPException(status_code=403, detail="Invalid webhook secret")
    return True

class InvoiceNinjaService:
    """Service for interacting with Invoice Ninja API"""
    
    def __init__(self):
        self.base_url = INVOICE_NINJA_URL
        self.token = INVOICE_NINJA_TOKEN
        self.headers = {
            "Authorization": f"Bearer {self.token}",
            "Content-Type": "application/json",
            "X-API-Secret": self.token,  # Some Invoice Ninja setups require this
        }
    
    def transform_user_to_client(self, user_data: UserData) -> InvoiceNinjaClient:
        """Transform Django user data to Invoice Ninja client format"""
        
        # Prepare private notes with additional user information
        private_notes_parts = [
            f"Django User ID: {user_data.django_user_id}",
            f"Signup Date: {user_data.date_joined[:10]}",
        ]
        
        if user_data.date_of_birth:
            private_notes_parts.append(f"Date of Birth: {user_data.date_of_birth}")
        
        if user_data.emergency_contact_name:
            private_notes_parts.append(
                f"Emergency Contact: {user_data.emergency_contact_name} "
                f"({user_data.emergency_contact_relationship}) - {user_data.emergency_contact_phone}"
            )
        
        if user_data.medical_conditions and user_data.medical_conditions.lower() != "none":
            private_notes_parts.append(f"Medical Conditions: {user_data.medical_conditions}")
        
        if user_data.allergies and user_data.allergies.lower() != "none":
            private_notes_parts.append(f"Allergies: {user_data.allergies}")
        
        # Prepare public notes for referral information
        public_notes_parts = []
        if user_data.referral_code:
            public_notes_parts.append(f"Referral Code: {user_data.referral_code}")
        if user_data.referred_by:
            public_notes_parts.append(f"Referred By: {user_data.referred_by}")
        
        return InvoiceNinjaClient(
            name=user_data.full_name or f"{user_data.first_name} {user_data.last_name}".strip(),
            primary_contact={
                "first_name": user_data.first_name,
                "last_name": user_data.last_name,
                "email": user_data.email,
                "phone": user_data.phone_number or "",
            },
            custom_value1=user_data.referral_code or "",  # Referral Code
            custom_value2=user_data.referred_by or "",    # Referred By
            custom_value3=user_data.nationality or "",    # Nationality
            custom_value4=str(user_data.django_user_id),  # Django User ID
            private_notes="\n".join(private_notes_parts),
            public_notes="\n".join(public_notes_parts),
        )
    
    async def create_client(self, client_data: InvoiceNinjaClient) -> Dict[str, Any]:
        """Create a client in Invoice Ninja"""
        
        async with httpx.AsyncClient(timeout=30.0) as client:
            try:
                logger.info(f"Creating Invoice Ninja client for: {client_data.name}")
                
                response = await client.post(
                    f"{self.base_url}/api/v1/clients",
                    headers=self.headers,
                    json=client_data.dict()
                )
                
                if response.status_code == 200:
                    client_response = response.json()
                    client_id = client_response["data"]["id"]
                    logger.info(f"Successfully created Invoice Ninja client: {client_id}")
                    return {
                        "success": True,
                        "client_id": client_id,
                        "client_data": client_response["data"]
                    }
                else:
                    logger.error(f"Failed to create Invoice Ninja client: {response.status_code} - {response.text}")
                    return {
                        "success": False,
                        "error": f"HTTP {response.status_code}: {response.text}",
                        "retry": response.status_code in [429, 500, 502, 503, 504]  # Retry on these status codes
                    }
                    
            except httpx.TimeoutException:
                logger.error("Timeout while creating Invoice Ninja client")
                return {
                    "success": False,
                    "error": "Request timeout",
                    "retry": True
                }
            except Exception as e:
                logger.error(f"Unexpected error creating Invoice Ninja client: {str(e)}")
                return {
                    "success": False,
                    "error": f"Unexpected error: {str(e)}",
                    "retry": True
                }

class DjangoCallbackService:
    """Service for sending callbacks to Django"""
    
    def __init__(self):
        self.callback_url = DJANGO_CALLBACK_URL
        self.headers = {
            "Content-Type": "application/json",
            "User-Agent": "InvoiceNinja-Integration-Service/1.0"
        }
        
        if WEBHOOK_SECRET:
            self.headers["X-Webhook-Secret"] = WEBHOOK_SECRET
    
    async def send_callback(self, payload: CallbackPayload) -> bool:
        """Send callback to Django"""
        
        async with httpx.AsyncClient(timeout=30.0) as client:
            try:
                logger.info(f"Sending callback to Django for user {payload.django_user_id}")
                
                response = await client.post(
                    self.callback_url,
                    headers=self.headers,
                    json=payload.dict()
                )
                
                if response.status_code == 200:
                    logger.info(f"Successfully sent callback for user {payload.django_user_id}")
                    return True
                else:
                    logger.error(f"Failed to send callback: {response.status_code} - {response.text}")
                    return False
                    
            except Exception as e:
                logger.error(f"Error sending callback to Django: {str(e)}")
                return False

# Service instances
invoice_ninja_service = InvoiceNinjaService()
django_callback_service = DjangoCallbackService()

@app.get("/")
async def root():
    """Health check endpoint"""
    return {
        "status": "healthy",
        "service": "Invoice Ninja Integration Service",
        "version": "1.0.0",
        "timestamp": datetime.utcnow().isoformat()
    }

@app.get("/health")
async def health_check():
    """Detailed health check"""
    return {
        "status": "healthy",
        "invoice_ninja_url": INVOICE_NINJA_URL,
        "django_callback_url": DJANGO_CALLBACK_URL,
        "webhook_secret_configured": bool(WEBHOOK_SECRET),
        "timestamp": datetime.utcnow().isoformat()
    }

@app.post("/webhook/invoice-ninja-sync")
async def sync_user_to_invoice_ninja(
    payload: WebhookPayload,
    _: bool = Depends(verify_webhook_secret)
):
    """
    Main webhook endpoint that receives Django user data and creates Invoice Ninja clients
    """
    logger.info(f"Received webhook for user {payload.data.django_user_id} - {payload.data.email}")
    
    try:
        # Transform user data to Invoice Ninja client format
        client_data = invoice_ninja_service.transform_user_to_client(payload.data)
        
        # Create client in Invoice Ninja
        result = await invoice_ninja_service.create_client(client_data)
        
        # Prepare callback payload
        if result["success"]:
            callback_payload = CallbackPayload(
                django_user_id=payload.data.django_user_id,
                success=True,
                invoice_ninja_client_id=result["client_id"],
                message="Client created successfully in Invoice Ninja"
            )
        else:
            callback_payload = CallbackPayload(
                django_user_id=payload.data.django_user_id,
                success=False,
                message=result.get("error", "Unknown error occurred"),
                retry=result.get("retry", False)
            )
        
        # Send callback to Django (don't block on this)
        asyncio.create_task(django_callback_service.send_callback(callback_payload))
        
        # Return response
        return {
            "success": result["success"],
            "message": "Processing completed",
            "client_id": result.get("client_id"),
            "django_user_id": payload.data.django_user_id
        }
        
    except Exception as e:
        logger.error(f"Unexpected error processing webhook: {str(e)}")
        
        # Send failure callback
        callback_payload = CallbackPayload(
            django_user_id=payload.data.django_user_id,
            success=False,
            message=f"Service error: {str(e)}",
            retry=True
        )
        asyncio.create_task(django_callback_service.send_callback(callback_payload))
        
        raise HTTPException(status_code=500, detail="Internal service error")

@app.post("/webhook/bulk-sync")
async def bulk_sync_users(
    users: list[UserData],
    _: bool = Depends(verify_webhook_secret)
):
    """
    Bulk sync endpoint for processing multiple users at once
    """
    logger.info(f"Received bulk sync request for {len(users)} users")
    
    results = []
    
    for user_data in users:
        try:
            # Transform and create client
            client_data = invoice_ninja_service.transform_user_to_client(user_data)
            result = await invoice_ninja_service.create_client(client_data)
            
            result_item = {
                "django_user_id": user_data.django_user_id,
                "success": result["success"]
            }
            
            if result["success"]:
                result_item["invoice_ninja_client_id"] = result["client_id"]
            else:
                result_item["error"] = result.get("error", "Unknown error")
                result_item["retry"] = result.get("retry", False)
            
            results.append(result_item)
            
        except Exception as e:
            logger.error(f"Error processing user {user_data.django_user_id}: {str(e)}")
            results.append({
                "django_user_id": user_data.django_user_id,
                "success": False,
                "error": f"Processing error: {str(e)}",
                "retry": True
            })
    
    # Send bulk callback to Django
    bulk_callback_payload = {
        "batch_id": f"bulk_{datetime.utcnow().strftime('%Y%m%d_%H%M%S')}",
        "results": results,
        "timestamp": datetime.utcnow().isoformat()
    }
    
    # Send to bulk callback endpoint
    bulk_callback_url = DJANGO_CALLBACK_URL.replace("/client-created/", "/bulk-sync/")
    asyncio.create_task(
        django_callback_service.send_callback_custom(bulk_callback_url, bulk_callback_payload)
    )
    
    success_count = sum(1 for r in results if r["success"])
    
    return {
        "success": True,
        "message": f"Processed {len(results)} users",
        "total_users": len(results),
        "successful": success_count,
        "failed": len(results) - success_count,
        "results": results
    }

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8001)
