FROM apache/superset:latest

USER root

# Install PostgreSQL driver
RUN pip install psycopg2-binary

# Copy startup script
COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh


USER superset

# Set secret key (change this to a random string)
ENV SUPERSET_SECRET_KEY='99b0V3oCt99AzUVqNDTrd38cumra2Fs3ocHIBQ-nUpg'

# Initialize Superset database
RUN superset db upgrade

# Create admin user
RUN superset fab create-admin \
    --username jinal \
    --firstname Jinal \
    --lastname Swarnakar \
    --email jinal.swarnakar@fiftyfivetech.io \
    --password 123

# Initialize Superset
RUN superset init

# Expose port
EXPOSE 8080

# Start Superset
CMD ["/app/start.sh"]