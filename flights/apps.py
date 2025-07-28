from django.apps import AppConfig


class FlightsConfig(AppConfig):
    default_auto_field = 'django.db.models.BigAutoField'
    name = 'flights'
    verbose_name = 'Flight Management'
    
    def ready(self):
        # Import signals if needed
        # import flights.signals
        pass
