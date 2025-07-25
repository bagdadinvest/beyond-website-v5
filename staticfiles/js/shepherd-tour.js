document.addEventListener('DOMContentLoaded', function () {
    const tour = new Shepherd.Tour({
        useModalOverlay: true,
        defaultStepOptions: {
            scrollTo: true,
            cancelIcon: {
                enabled: true
            },
            classes: 'shepherd-theme-arrows',
            buttons: [
                {
                    text: 'Next',
                    action: Shepherd.next
                },
                {
                    text: 'Cancel',
                    action: Shepherd.cancel
                }
            ]
        }
    });

    tour.addStep({
        id: 'welcome',
        text: 'Welcome to the Django Admin Panel!',
        attachTo: {
            element: '.branding',
            on: 'bottom'
        },
        buttons: [
            {
                text: 'Next',
                action: tour.next
            }
        ]
    });

    // Add more steps as needed
    tour.start();
});
