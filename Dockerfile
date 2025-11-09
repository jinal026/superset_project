# Use the official Superset image
FROM apache/superset:latest

# Switch to root to install system dependencies
USER root

# Install system packages required for psycopg2
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        build-essential \
        libpq-dev \
        postgresql-client \
        git \
        curl \
        dos2unix && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY requirements.txt /app/

# Ensure pip exists in Superset's virtualenv and install psycopg2
RUN /app/.venv/bin/python -m ensurepip && \
    /app/.venv/bin/python -m pip install --no-cache-dir --upgrade pip setuptools wheel && \
    /app/.venv/bin/python -m pip install --no-cache-dir -r /app/requirements.txt

# Verify psycopg2 installation
RUN /app/.venv/bin/python -c "import psycopg2; print('✅ psycopg2 version:', psycopg2.__version__)"

# Copy Superset config and start script
COPY superset_config.py /app/superset_config.py
COPY start.sh /app/start.sh

# Convert start.sh to Unix line endings & make executable
RUN dos2unix /app/start.sh && chmod +x /app/start.sh

# Set Superset config environment variable
ENV SUPERSET_CONFIG_PATH=/app/superset_config.py

# Switch back to superset user
USER superset

# Final verification as superset user
RUN /app/.venv/bin/python -c "import psycopg2; print('✅ psycopg2 accessible by superset user')"

# Set working directory
WORKDIR /app

# Expose Superset port
EXPOSE 8088

# Start Superset
CMD ["bash", "/app/start.sh"]

