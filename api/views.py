from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
import subprocess
import os

class DjangoShellInteractiveView(APIView):
    permission_classes = []  # Remove authentication temporarily

    def post(self, request):
        # Get the code snippet to execute
        code_snippet = request.data.get("code")
        if not code_snippet:
            return Response({"error": "Code is required"}, status=status.HTTP_400_BAD_REQUEST)

        try:
            # Define the shell_plus command
            command = f'source venv/bin/activate && python manage.py shell_plus -c "{code_snippet}"'

            # Execute the command in a shell
            process = subprocess.run(
                command,
                shell=True,
                text=True,
                capture_output=True,
                cwd=os.getcwd(),  # Ensure the working directory is your project directory
            )

            # Check for errors
            if process.returncode != 0:
                return Response(
                    {"error": process.stderr.strip()},
                    status=status.HTTP_500_INTERNAL_SERVER_ERROR,
                )

            # Return the output
            return Response({"output": process.stdout.strip()}, status=status.HTTP_200_OK)

        except Exception as e:
            return Response({"error": str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)
