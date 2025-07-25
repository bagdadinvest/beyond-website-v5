## from celery import shared_task
## from .models import User
## from django_openai_assistant.assistant import assistantTask

## def initialize_thread(user_id):
##     try:
##         user = User.objects.get(id=user_id)
##         task = assistantTask(
##             assistantName="Beyond Buddy",
##             tools=[],
##             completionCall="apps.test:afterRunFunction"
##         )
##         task.prompt = "Welcome! How can I assist you today?"
##         run_id = task.createRun()
##         if run_id:
##             user.thread_id = task.thread_id
##             user.save()
##     except User.DoesNotExist:
##         print(f"User with ID {user_id} does not exist.")
##     except Exception as e:
##         print(f"Error initializing thread for user {user_id}: {e}")
