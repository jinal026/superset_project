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

# Enable feature flags
FEATURE_FLAGS = {
    # Native Filters (required for horizontal filters)
    "DASHBOARD_NATIVE_FILTERS": True,
    "DASHBOARD_NATIVE_FILTERS_SET": True,
    "DASHBOARD_CROSS_FILTERS": True,
    
    # Template processing (required for time filters)
    "ENABLE_TEMPLATE_PROCESSING": True,
    "ENABLE_TEMPLATE_REMOVE_FILTERS": True,
    
    # Additional filter features
    "DASHBOARD_FILTERS_EXPERIMENTAL": True,
    "GLOBAL_ASYNC_QUERIES": True,
    
    # Enable all time-related features
    "ENABLE_JAVASCRIPT_CONTROLS": True,
    "ENABLE_EXPLORE_JSON_CSRF_PROTECTION": False,
    
    # Horizontal layout
    "HORIZONTAL_FILTER_BAR": True,
}

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

# Configure metadata database connection pool
SQLALCHEMY_ENGINE_OPTIONS = {
    "pool_pre_ping": True,
    "pool_recycle": 3600,
}

# Time grain configurations for time range filters
TIME_GRAIN_ADDONS = {
    'PT1S': '1 second',
    'PT1M': '1 minute',
    'PT5M': '5 minutes',
    'PT10M': '10 minutes',
    'PT15M': '15 minutes',
    'PT30M': '30 minutes',
    'PT1H': '1 hour',
    'P1D': '1 day',
    'P1W': '1 week',
    'P1M': '1 month',
    'P1Y': '1 year',
}

