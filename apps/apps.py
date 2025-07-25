from django.apps import AppConfig

class MyAppConfig(AppConfig):
    name = 'apps'

    def ready(self):
        # Import the registry and your models here to ensure apps are loaded
        from actstream import registry
        from .models import (
            User, Insurance, EmergencyContact, MedicalInformation, 
            Hospital, Referral, Appointment, HospitalStay, Prescription, 
            MessageGroup, Message, Subscription, Contact, EmailTemplate,
            TreatmentPlan, TreatmentPlanItem  # Add these models
        )

        # Import signals to ensure they are connected
        import apps.signals  # This ensures your signals.py is loaded

        # Register your models with actstream
        registry.register(User)
        registry.register(Insurance)
        registry.register(EmergencyContact)
        registry.register(MedicalInformation)
        registry.register(Hospital)
        registry.register(Referral)
        registry.register(Appointment)
        registry.register(HospitalStay)
        registry.register(Prescription)
        registry.register(MessageGroup)
        registry.register(Message)
        registry.register(Subscription)
        registry.register(Contact)
        registry.register(EmailTemplate)
        registry.register(TreatmentPlan)  # Register the TreatmentPlan model
        registry.register(TreatmentPlanItem)  # Register the TreatmentPlanItem model
