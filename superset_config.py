import os

# Database configuration
SQLALCHEMY_DATABASE_URI = os.environ.get(
    "DATABASE_URL",
    "postgresql://postgres:ySglnskQzWBsOziiNiihRusbmXiLyWMJ@metro.proxy.rlwy.net:38035/railway?sslmode=require"
)

# Secret key for session management
SECRET_KEY = os.environ.get(
    "SECRET_KEY", 
    "99b0V3oCt99AzUVqNDTrd38cumra2Fs3ocHIBQ-nUpg"
)

# Server configuration
SUPERSET_WEBSERVER_PORT = int(os.environ.get("PORT", 8088))

# CORS configuration
ENABLE_CORS = True
CORS_OPTIONS = {
    "supports_credentials": True,
    "allow_headers": ["*"],
    "resources": ["/*"],
    "origins": ["*"],
}

# Prevent users from disabling SQL Lab
SQLLAB_CTAS_NO_LIMIT = True

# Enable feature flags
FEATURE_FLAGS = {
    "DASHBOARD_NATIVE_FILTERS": True,
    "DASHBOARD_CROSS_FILTERS": True,
    "DASHBOARD_NATIVE_FILTERS_SET": True,
    "DASHBOARD_NATIVE_FILTERS_HORIZONTAL": True,  # 👈 enables horizontal filters
}
# Configure metadata database connection pool
SQLALCHEMY_ENGINE_OPTIONS = {
    "pool_pre_ping": True,
    "pool_recycle": 3600,
}