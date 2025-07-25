from django.contrib.admin.views.decorators import staff_member_required
from django.shortcuts import render
from actstream.models import Action

@staff_member_required  # This decorator ensures only admin users can access the view
def action_log_view(request):
    # Fetch the latest 50 actions
    actions = Action.objects.all().order_by('-timestamp')[:50]
    return render(request, 'action_log.html', {'actions': actions})
