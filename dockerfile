# Use an official Python runtime as a parent image
FROM python:3.9-slim-buster

# Copy the poetry.lock and pyproject.toml files to the container
COPY . /app

# Set the working directory to /app
WORKDIR /app

# Install Poetry
RUN pip install poetry

RUN apt-get update && apt-get install -y curl && \
    curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python && \
    . /root/.poetry/env && \
    poetry config virtualenvs.create false && \
    poetry install --no-interaction --no-ansi

# Make port 8000 available to the world outside this container
EXPOSE 8000

# Run the command to start the FastAPI application
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]