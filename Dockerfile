
FROM python:3.12-slim

ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PIP_NO_CACHE_DIR=off \
    PIP_DISABLE_PIP_VERSION_CHECK=on \
    PIP_DEFAULT_TIMEOUT=100 \
    # Use a Poetry version that supports dependency groups ([tool.poetry.group.*])
    POETRY_VERSION=1.8.3 \
    POETRY_HOME="/opt/poetry" \
    POETRY_VIRTUALENVS_IN_PROJECT=true \
    POETRY_NO_INTERACTION=1 \
    PYSETUP_PATH="/opt/pysetup" \
    VENV_PATH="/opt/pysetup/.venv"

ENV PATH="$POETRY_HOME/bin:$VENV_PATH/bin:$PATH"

RUN apt-get update \
    && apt-get install --no-install-recommends -y curl build-essential libpq-dev gcc \
    && rm -rf /var/lib/apt/lists/*

# Instalação do Poetry (script atualizado)
RUN curl -sSL https://install.python-poetry.org | python3 -

WORKDIR $PYSETUP_PATH
# Copy only Poetry files first to leverage Docker layer caching
COPY pyproject.toml ./
# If you commit a poetry.lock, uncomment the next line to speed up builds
# COPY poetry.lock ./
# Generate lock and install without dev dependencies (Poetry >=1.2)
RUN poetry lock && poetry install --without dev --no-interaction --no-ansi

WORKDIR /app
COPY . /app/

EXPOSE 8000

CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]