FROM python:latest

# Install pipx
RUN apt-get update && apt-get install -y pipx 
RUN pipx ensurepath

# Install poetry
RUN pip3 install poetry

# Set working directory
WORKDIR /app

# Install dependencies
COPY pyproject.toml ./
RUN pipx run poetry install --no-root

# Copy application files
COPY todo todo

# Adding a delay to allow the database to start
CMD ["bash", "-c", "sleep 10 && pipx run poetry run flask --app todo run --host 0.0.0.0 --port 6400"]
