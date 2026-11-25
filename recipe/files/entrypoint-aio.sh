#!/bin/bash
set -e
cd /app
export PATH=/opt/venv/bin:$PATH
# wait for postgres + redis (the orchestrator gates sidecars healthy; belt-and-suspenders)
until python -c "import sqlalchemy,os;sqlalchemy.create_engine(os.environ['REDASH_DATABASE_URL']).connect().close()" >/dev/null 2>&1; do echo "waiting for postgres..."; sleep 2; done
until python -c "import redis,os;redis.from_url(os.environ['REDASH_REDIS_URL']).ping()" >/dev/null 2>&1; do echo "waiting for redis..."; sleep 2; done
# first-boot: create_tables is a no-op on a non-empty DB; db upgrade applies pending migrations
python /app/manage.py database create_tables
# no `|| true`: db upgrade exits 0 on a fresh and on an up-to-date database (tested on v26.3.0), so a failure is a real
# migration error; stop here with it in the log instead of serving a half-migrated database.
python /app/manage.py db upgrade
exec supervisord -c /etc/supervisor/redash.conf -n
