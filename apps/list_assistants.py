from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
from django_openai_assistant.assistant import getAssistant

@csrf_exempt
def list_assistants(request):
    if request.method == 'GET':
        try:
            assistants = getAssistant()
            assistants_list = []
            
            for assistant in assistants.data:
                assistants_list.append({
                    'id': assistant.id,
                    'name': assistant.name,
                    'model': assistant.model,
                    'created_at': assistant.created_at
                })
            
            return JsonResponse({
                "status": "success",
                "assistants": assistants_list,
            }, status=200)
        
        except Exception as e:
            print(f"Error retrieving assistants: {e}")
            return JsonResponse({'error': str(e)}, status=500)
    else:
        return JsonResponse({'error': 'Invalid request method'}, status=405)
