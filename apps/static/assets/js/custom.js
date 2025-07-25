// Wait for the page to be ready
$(document).ready(function() {
    // Initialize DataTables
    $('#leadsTable').DataTable({
        "order": [[0, "asc"]],
        "paging": true,
        "searching": true,
        "info": true
    });

    // Initialize FullCalendar
    const calendarEl = document.getElementById('calendar');
    if (calendarEl) {  // Ensure the element exists
        const calendar = new FullCalendar.Calendar(calendarEl, {
            initialView: 'dayGridMonth',
            events: '/leads/calendar-events/',
            headerToolbar: {
                left: 'prev,next today',
                center: 'title',
                right: 'dayGridMonth,timeGridWeek,timeGridDay'
            },
            height: 'auto'
        });
        calendar.render();
    }
});
