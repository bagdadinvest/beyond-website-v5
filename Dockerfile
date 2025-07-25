# Use Python 3.10 as the base image
FROM python:3.11-slim

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy the current directory contents into the container at /usr/src/app
COPY . /usr/src/app

# Upgrade pip first
RUN pip install --upgrade pip
RUN apt-get update && apt-get install -y gcc g++ libc-dev && rm -rf /var/lib/apt/lists/*

# Install the psycopg2-binary package separately
RUN pip install psycopg2-binary

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Make port 8000 available to the world outside this container
EXPOSE 8000

# Define environment variable
ENV NAME World

# Run app.py when the container launches
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
