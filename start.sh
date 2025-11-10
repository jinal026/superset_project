#!/bin/bash
set -e

echo "=========================================="
echo "Apache Superset Initialization"
echo "=========================================="

# Use Superset's Python from venv for reliability
PYTHON=/app/.venv/bin/python

# Verify psycopg2
echo "Checking psycopg2..."
$PYTHON -c "import psycopg2; print(f'✅ psycopg2 version: {psycopg2.__version__}')" || {
    echo "❌ psycopg2 not found!"
    exit 1
}

# Use DATABASE_URL from environment; if not set, default to public Railway URL
DB_URL="${DATABASE_URL:-postgresql://postgres:ySglnskQzWBsOziiNiihRusbmXiLyWMJ@metro.proxy.rlwy.net:38035/railway?sslmode=require}"


# Test database connection
echo "Testing database connection..."
$PYTHON -c "
import psycopg2
import sys
try:
    conn = psycopg2.connect('$DB_URL')
    print('✅ Database connection successful')
    conn.close()
except Exception as e:
    print(f'❌ Database connection failed: {e}')
    sys.exit(1)
"

# Initialize Superset database
echo "Initializing Superset database..."
superset db upgrade

# Create admin user (ignore if already exists)
echo "Creating admin user..."
superset fab create-admin \
    --username jinal \
    --firstname Jinal \
    --lastname Swarnakar \
    --email jinal.swarnakar@fiftyfivetech.io \
    --password 123 2>/dev/null || echo "ℹ️  Admin user already exists"

# Initialize Superset roles and permissions
echo "Initializing Superset..."
superset init

echo "=========================================="
echo "✅ Starting Superset on port 8088"
echo "=========================================="

# Start Superset server
exec gunicorn "superset.app:create_app()" \
    --bind 0.0.0.0:$PORT \
    --workers 3 \
    --threads 3 \
    --timeout 120
