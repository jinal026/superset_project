# Apache Superset — Docker deployment

This repository provides a minimal Docker-based deployment of Apache Superset. It builds on the official
`apache/superset` image and includes project-level configuration and a small startup script so you can run
Superset locally or deploy to services that accept Docker containers (Railway, Render, VPS, etc.).

## What this project contains

- `Dockerfile` — builds a container image based on `apache/superset:latest` and installs any extra OS/Python
   dependencies required by the project.
- `superset_config.py` — optional Superset configuration copied into the image. Edit to customize behavior.
- `start.sh` — small wrapper used as the container CMD to initialize/run Superset.
- `requirements.txt` — (if present) additional Python dependencies for the app.

## Quick start — build and run locally

1. Build the Docker image (from the project root):

```bash
docker build -t superset-local .
```

2. Run the container and expose Superset's default port 8088:

```bash
docker run --rm -p 8088:8088 \
   -e SUPERSET_CONFIG_PATH=/app/superset_config.py \
   --name superset-local superset-local
```

3. Open http://localhost:8088 in your browser.

Notes:
- If `start.sh` performs migrations or creates an admin user, the container logs will show progress.
- When iterating on `superset_config.py` you can rebuild the image or mount the file at runtime using `-v`.

## Environment and configuration

- `SUPERSET_CONFIG_PATH` — path to the Superset config file inside the container. The Dockerfile sets
   `ENV SUPERSET_CONFIG_PATH=/app/superset_config.py` by default.
- `PYTHONPATH` — the project Dockerfile may set this if your code needs modules under `/app`.

## Common tasks

- Rebuild after changing Python dependencies or `superset_config.py`:

```bash
docker build -t superset-local .
```

- Run with a mounted config for fast iteration (host `superset_config.py` -> container `/app/superset_config.py`):

```bash
docker run --rm -p 8088:8088 -v $(pwd)/superset_config.py:/app/superset_config.py \
   -e SUPERSET_CONFIG_PATH=/app/superset_config.py superset-local
```

## Troubleshooting

- pip / psycopg2 install errors: the official Superset image uses a Python virtualenv at `/app/.venv`. If you
   see `No module named pip` or `ModuleNotFoundError: No module named 'psycopg2'` when building, use the venv's
   pip/python explicitly (example used in this repo's `Dockerfile`):

```dockerfile
# /app/.venv/bin/pip install psycopg2-binary
# /app/.venv/bin/python -c "import psycopg2"
```

- If database adapters (Postgres/MySQL) fail to build, ensure system build-deps are installed (`build-essential`,
   `libpq-dev`, etc.) before installing Python packages.

## Next steps and recommendations

- Add a small health-check script or Docker HEALTHCHECK for production deployments.
- If deploying to a managed container service, add a `docker-compose.yml` or service-specific deploy config.
- Consider adding tests and a basic CI pipeline to build the image and run a smoke test that checks
   the Superset web UI responds.

## License & attribution

This project builds on the official Apache Superset image. Refer to the Apache Superset project for
license and contribution details.

---

If you'd like, I can also:
- add a `docker-compose.yml` for local development,
- create a small smoke-test that runs the container and checks the web UI,
- or add an example `superset_config.py` with a Postgres backend configuration.
