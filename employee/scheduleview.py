import json
from django.shortcuts import render, get_object_or_404
from django.contrib.auth.decorators import login_required
from .models import WorkSchedule, DaySchedule
from django.shortcuts import render, redirect
from django.contrib.auth.decorators import user_passes_test
from .forms import WorkScheduleForm, MakeRequestForm
from django.core.serializers.json import DjangoJSONEncoder
from django.forms import inlineformset_factory
from datetime import datetime, timedelta




def admin_check(user):
    return user.is_superuser or user.groups.filter(name='Admins').exists()

@user_passes_test(admin_check)
def admin_manage_schedules(request):
    """
    Admin view to see and manage all employee schedules.
    """
    schedules = WorkSchedule.objects.all()
    context = {
        'schedules': schedules,
    }
    return render(request, 'admin_schedules.html', context)


DayScheduleFormSet = inlineformset_factory(WorkSchedule, DaySchedule, fields=('day_of_week', 'active', 'start_time', 'end_time', 'work_type'))


@user_passes_test(admin_check)
def edit_schedule(request, schedule_id):
    schedule = get_object_or_404(WorkSchedule, id=schedule_id)
    DayScheduleFormSet = inlineformset_factory(WorkSchedule, DaySchedule, fields=('day_of_week', 'active', 'start_time', 'end_time', 'work_type'))
    
    if request.method == 'POST':
        formset = DayScheduleFormSet(request.POST, instance=schedule)
        if formset.is_valid():
            formset.save()
            return redirect('admin-manage-schedules')
    else:
        formset = DayScheduleFormSet(instance=schedule)

    context = {
        'formset': formset,
        'schedule': schedule,
    }
    return render(request, 'edit_schedule.html', context)

@user_passes_test(admin_check)
def delete_schedule(request, schedule_id):
    """
    Admin view to delete a specific employee's work schedule.
    """
    schedule = get_object_or_404(WorkSchedule, id=schedule_id)
    schedule.delete()
    return redirect('admin-manage-schedules')


def employee_schedule_view(request):
    """
    View for employees to see their work schedule for the week.
    """
    # Get the current user's work schedule
    work_schedule = WorkSchedule.objects.filter(employee=request.user).first()

    # Prepare events data for FullCalendar
    events = []
    if work_schedule:
        for schedule in work_schedule.schedules.all():
            if schedule.active:
                day_offset = {
                    'Sunday': 6,
                    'Monday': 0,
                    'Tuesday': 1,
                    'Wednesday': 2,
                    'Thursday': 3,
                    'Friday': 4,
                    'Saturday': 5,
                }[schedule.day_of_week]

                event_start = (datetime.now() - timedelta(days=datetime.now().weekday())) + timedelta(days=day_offset)
                
                events.append({
                    'title': f"Work - {'Office' if schedule.work_type == 'office' else 'Remote'}",
                    'start': f"{event_start.date()}T{schedule.start_time}",
                    'end': f"{event_start.date()}T{schedule.end_time}",
                })
    
    context = {
        'events': json.dumps(events, cls=DjangoJSONEncoder)  # Convert Python data into JSON
    }

    return render(request, 'scheduletemp.html', context)
