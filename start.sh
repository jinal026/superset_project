#!/bin/bash
# start.sh — Superset startup for Railway

. /opt/venv/bin/activate

# Environment variables
export SUPERSET_SECRET_KEY="99b0V3oCt99AzUVqNDTrd38cumra2Fs3ocHIBQ-nUpg"
export FLASK_APP=superset
export SUPerset_HOME=/app/superset_home

# Initialize the Superset DB
superset db upgrade

# Create admin (only if not exists)
superset fab create-admin \
  --username jinal \
  --firstname Jinal \
  --lastname Swarnakar \
  --email jinal.swarnakar@fiftyfivetech.io \
  --password 123 || true

# Initialize roles, permissions, etc.
superset init

# Run Superset on Railway port
PORT=${PORT:-8080}
superset run -h 0.0.0.0 -p $PORT --with-threads --reload --debugger
