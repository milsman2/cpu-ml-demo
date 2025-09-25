# Builder stage
FROM python:3.13-slim AS builder

WORKDIR /app

# Install build dependencies and uv
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
    gcc \
    build-essential \
    make \
    libffi-dev \
    libssl-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && pip install uv

# Copy dependency files
COPY pyproject.toml uv.lock ./

RUN uv sync --frozen --no-install-project --no-dev

# Copy the application code
COPY ./src /app/src

# Final stage
FROM python:3.13-slim

WORKDIR /app

# Install psql client and uv
RUN apt-get update && \
    apt-get install -y --no-install-recommends && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* \
    && pip install uv

# Copy the virtual environment from builder
COPY --from=builder /app/.venv /app/.venv

# Copy the application code from builder
COPY --from=builder /app/src /app/src
# Add the virtual environment to PATH
ENV PATH="/app/.venv/bin:$PATH"

# Command to run the pre-start script and then start the FastAPI application
CMD ["uv", "run", "src/main.py"]