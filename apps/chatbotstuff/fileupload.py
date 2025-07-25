from openai import OpenAI

client = OpenAI(api_key="sk-proj-LndyD4NJ0XLskQVEa0vxT3BlbkFJbOFqGrAFjmzKUfHERVwQ")

client.files.create(
   file=open("C:/Users/Admin/Downloads/beyondbuddy.json", "rb"),
   purpose="assistants"
)
