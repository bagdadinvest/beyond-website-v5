# test.view.py
from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
from django_openai_assistant.assistant import assistantTask
from celery import shared_task

@csrf_exempt
def test_assistant_view(request):
    if request.method == 'POST':
        try:
            task = assistantTask(
                assistantName="Beyond Buddy",
                tools=[],
                completionCall="app.after_run_function"
            )
            task.prompt = "Who was Napoleon Bonaparte?"
            task_id = task.createRun()

            return JsonResponse({
                'status': 'success',
                'task_id': task_id
            }, status=200)

        except Exception as e:
            return JsonResponse({
                'status': 'error',
                'message': str(e)
            }, status=500)
    else:
        return JsonResponse({'error': 'Invalid request method'}, status=405)

@shared_task(name="This will be called once the run is complete")
def after_run_function(taskID):
    task = assistantTask(run_id=taskID)
    if task.status == 'completed':
        print(task.markdownResponse())
    else:
        print('run failed')
