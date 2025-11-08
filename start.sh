#!/bin/bash

# Get PORT from environment or use default
PORT=${PORT:-8080}

echo "Starting Superset on port $PORT"

# Start Superset
superset run -h 0.0.0.0 -p $PORT --with-threads --reload