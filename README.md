# Apache Superset on Railway

This repo deploys Apache Superset fully on Railway without Docker.

### Steps to deploy
1. Add a PostgreSQL service in your Railway project.
2. Copy the `postgresql` connection URL (from your DB service).
3. Deploy this repo.
4. Once running, open Superset → Settings → Database Connections.
5. Add your internal Railway Postgres connection string, e.g.:

