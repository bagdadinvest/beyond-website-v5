# Dashboard Template Refactoring

## Overview
The dashboard template has been refactored for better modularity and maintainability. All components are now extracted into focused, reusable partials.

## Directory Structure
```
apps/app_templates/
├── dashboard.html (main template - now minimal and clean)
└── includes/dashboard/
    ├── accommodations_card.html
    ├── appointments_card.html
    ├── balance_referral_card.html
    ├── flight_reservations_card.html
    ├── messages_card.html
    ├── prescriptions_card.html
    ├── referral_link_js.html
    ├── referral_modal.html
    ├── schedules_card.html
    └── shepherd_tour.html
```

## Components

### Card Components
- **messages_card.html**: New messages count and link to view messages
- **appointments_card.html**: Upcoming appointments count and link to schedule
- **prescriptions_card.html**: Active prescriptions count and link to prescriptions
- **balance_referral_card.html**: Current balance display and referral link generation
- **accommodations_card.html**: Accommodations count and management link
- **flight_reservations_card.html**: Flight reservations count and ticket upload link
- **schedules_card.html**: Schedules count and view schedule link

### Modal Components
- **referral_modal.html**: Modal for displaying and copying referral links

### JavaScript Components
- **shepherd_tour.html**: Complete Shepherd.js tour setup and configuration
- **referral_link_js.html**: JavaScript for referral link generation and copying

## Benefits

1. **Modularity**: Each component is self-contained and focused on a single responsibility
2. **Reusability**: Components can be easily reused in other templates
3. **Maintainability**: Easy to modify individual components without affecting others
4. **Readability**: Main dashboard.html is now clean and easy to understand
5. **Testing**: Individual components can be tested in isolation
6. **Translation**: All translation tags (`{% trans %}`) are preserved in components

## Usage

The main dashboard.html template now simply includes the components:

```django
{% include "includes/dashboard/messages_card.html" %}
{% include "includes/dashboard/appointments_card.html" %}
{% include "includes/dashboard/prescriptions_card.html" %}
{% include "includes/dashboard/balance_referral_card.html" %}
```

All dynamic context variables (like `unread_count`, `user.upcoming_appointments.count`, etc.) continue to work as they are passed down through the template context.

## Context Variables Required

The following context variables should be provided to the dashboard template:
- `unread_count`
- `user.upcoming_appointments.count`
- `user.active_prescriptions.count`
- `accommodations.count`
- `flight_reservations.count`
- `schedules.count`
- `csrf_token`

## Notes

- All translation tags (`{% trans %}`) are preserved
- All CSS classes and styling remain unchanged
- All JavaScript functionality is preserved
- All data-step attributes for Shepherd.js tour are maintained
- Modal functionality and referral link generation continue to work
