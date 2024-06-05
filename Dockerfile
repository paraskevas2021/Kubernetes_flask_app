# Loading the Python image from Docker Hub
FROM python:3.9-slim AS backend

# Setting the PYTHONUNBUFFERED environment variable to disable output/input buffering
ENV PYTHONUNBUFFERED=1

# Installing necessary Python dependencies
RUN pip install --upgrade pip
COPY requirements.txt .
RUN pip install -r requirements.txt

# Adding Flask application files to the working directory
COPY . /app
WORKDIR /app

# Setting the FLASK_APP environment variable
ENV FLASK_APP=app.py

# Updating the database
RUN flask db upgrade

# Default command to be executed when the container starts
CMD ["gunicorn", "--bind", "0.0.0.0:4000", "app:app"]
