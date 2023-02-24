FROM python:3.9-slim-buster

# Set working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y curl && \
    curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python && \
    . /root/.poetry/env && \
    poetry config virtualenvs.create false

# Install project dependencies
COPY pyproject.toml poetry.lock /app/
RUN . /root/.poetry/env && poetry install --no-interaction --no-ansi

# Copy project files
COPY . /app

# Expose port
EXPOSE 8000

# Start server
CMD [". /root/.poetry/env && uvicorn app.main:app --host=0.0.0.0 --port=8000"]