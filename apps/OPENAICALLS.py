OPENAICALLS.PY
import os
from openai import OpenAI
import markdown

def getOpenaiClient():
    return OpenAI( api_key=settings.OPENAI_API_KEY)
   
def getAssistant(Name,tools=None, Instructions):
    # retrieve an OpenAI assistant by Name or create one if not found.
    # in that case you should add your getTools() call so that the assistant
    # is created with the right tools attached to it. 
    client = getOpenaiClient()
    aa = client.beta.assistants.list()
    assistant = None
    for a in aa.data:
        if a.name == Name:
            assistant = a
            break
    if assistant == None: # create a new Agent
        assistant = client.beta.assistants.create(
        name=Name,
        instructions=Instructions
        tools=tools,
        model="gpt-3.5-turbo-16k")
    return assistant

def applyMarkdown(text):
    # this make the openAi answer nice for HTML - optional
    extension_configs = {
        'markdown_link_attr_modifier': {
            'new_tab': 'on',
            'no_referrer': 'external_only',
            'auto_title': 'on',
        }
    }
    return markdown.markdown(text,extensions=['tables','markdown_link_attr_modifier'],extension_configs=extension_configs)

def runOpenai(thread_id,assistant_id,instructions=None):
    client = getOpenaiClient()
    run = client.beta.threads.runs.create(
        thread_id=thread_id,
        assistant_id= assistant_id,
        instructions= instructions
    )
    while True:
        run = client.beta.threads.runs.retrieve(thread_id=thread_id, run_id=run.id)
        if run.status == 'completed':
            break
        elif run.status == 'requires_action':
            print('requires action')
            tool_calls = run.required_action.submit_tool_outputs.tool_calls
            tool_outputs = calTools(tool_calls)
            run = client.beta.threads.runs.submit_tool_outputs(
                thread_id=thread_id,
                run_id=run.id,
                tool_outputs=tool_outputs
            )
        time.sleep(.1) 
    return run
