import os
from dotenv import load_dotenv
load_dotenv()

SQLALCHEMY_DATABASE_URI = os.getenv("SQLALCHEMY_DATABASE_URI")
SECRET_KEY = os.getenv("SUPERSET_SECRET_KEY")
REDIS_URL = os.getenv("REDIS_URL")

CACHE_CONFIG = {
    "CACHE_TYPE": "RedisCache",
    "CACHE_DEFAULT_TIMEOUT": 300,
    "CACHE_KEY_PREFIX": "superset_",
    "CACHE_REDIS_URL": REDIS_URL,
}

CELERY_CONFIG = {
    "broker_url": REDIS_URL,
    "result_backend": REDIS_URL,
}


import os

# Secret key
SECRET_KEY = os.environ.get("SUPERSET_SECRET_KEY", "150110d459737f62606d36486624e93237f2eee4a8b1e181028c930ef7715b0a")

# Database
SQLALCHEMY_DATABASE_URI = os.environ.get(
    "SQLALCHEMY_DATABASE_URI",
    "postgresql://postgres:xDQuZDXElkMkvPWawfLfNBvylGRXQmIi@shuttle.proxy.rlwy.net:22113/railway"
)

# Redis (for caching & async queries)
CACHE_CONFIG = {
    'CACHE_TYPE': 'RedisCache',
    'CACHE_DEFAULT_TIMEOUT': 300,
    'CACHE_KEY_PREFIX': 'superset_',
    'CACHE_REDIS_URL': os.environ.get("REDIS_URL", "redis://:fkTjgmjbobCFvRgNcvcTsRTVKjdJQuQM@${{RAILWAY_PRIVATE_DOMAIN}}:6379/0"),
}

# Other optional configs
FEATURE_FLAGS = {
    "SIP_38_ENABLED": True
}
