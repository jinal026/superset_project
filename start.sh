# #!/bin/bash
# # start.sh — Superset startup for Railway

# . /opt/venv/bin/activate

# # Environment variables
# export SUPERSET_SECRET_KEY="99b0V3oCt99AzUVqNDTrd38cumra2Fs3ocHIBQ-nUpg"
# export FLASK_APP=superset
# export SUPerset_HOME=/app/superset_home

# # Initialize the Superset DB
# superset db upgrade

# # Create admin (only if not exists)
# superset fab create-admin \
#   --username jinal \
#   --firstname Jinal \
#   --lastname Swarnakar \
#   --email jinal.swarnakar@fiftyfivetech.io \
#   --password 123 || true

# # Initialize roles, permissions, etc.
# superset init

# # Run Superset on Railway port
# PORT=${PORT:-8080}
# superset run -h 0.0.0.0 -p $PORT --with-threads --reload --debugger


#!/bin/bash
set -e

# Create virtual environment (inside Railway)
python -m venv .venv
source .venv/bin/activate

# Install dependencies
pip install --upgrade pip
pip install -r requirements.txt

# Initialize Superset (only first time)
superset fab create-admin \
   --username admin \
   --firstname Superset \
   --lastname Admin \
   --email admin@example.com \
   --password admin || true

superset db upgrade
superset init

# Start Superset on port 8088
gunicorn --bind 0.0.0.0:8088 "superset.app:create_app()"
