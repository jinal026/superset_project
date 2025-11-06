FROM apache/superset:latest

# Copy env and config
COPY superset_config.py /app/superset_home/
COPY .env /app/superset_home/

# Install dependencies
RUN pip install --no-cache-dir python-dotenv psycopg2-binary redis pillow
