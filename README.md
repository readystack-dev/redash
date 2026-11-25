# Redash: ReadyStack build kit

The offline build kit for the Docker image `readystack/redash:v26.9.0-CE-ubuntu24.04-r8`. It holds what the image is built from (upstream source, base images, toolchain, pinned dependencies) and the documents, so the image can be rebuilt with no network access (`docker build --network=none`).

- Release: [v26.9.0-CE-ubuntu24.04-r8](https://github.com/readystack-dev/redash/releases/tag/v26.9.0-CE-ubuntu24.04-r8)
- Image: [`docker.io/readystack/redash:v26.9.0-CE-ubuntu24.04-r8`](https://hub.docker.com/r/readystack/redash/tags), manifest digest `sha256:a6e4f54c6e668de2218297d6784084885c47e7c17cb92b3bafddc0cd9bd09109`
- Product page: https://readystack.dev/products/redash
- Source and build recipe: https://readystack.dev/products/redash/recipe
- Build trail: https://readystack.dev/products/redash/trail/v26.9.0-CE-ubuntu24.04-r8
- Defects: this repository's Issues (defects recorded from 25 November 2026 on) and https://readystack.dev/defects.html?product=redash

## The image

ONE product container (supervisord runs the gunicorn web server [:5000] + an RQ worker listening on all six queues + the RQ scheduler) PLUS two required datastore sidecars the customer provides: PostgreSQL and Redis. NOT self-contained. This LEAN CE image ships the MAIN dependency set only: the ~45 optional datasource drivers of upstream's all_ds group (snowflake, cassandra, mysqlclient, pandas, etc.), the GPL-conflicting ldap3 extra, and the proprietary msodbcsql18/Simba ODBC drivers are NOT included — query runners degrade gracefully (a runner is enabled only when its Python driver imports). PostgreSQL/JSON/URL/Prometheus/Elasticsearch/ClickHouse-class runners work out of the box; MySQL and CSV are not available (their drivers, mysqlclient and pandas, are in all_ds), and the Microsoft SQL Server (ODBC) and Databricks types are listed (their Python driver, pyodbc, is installed) but cannot connect, because no ODBC driver is installed.

## Who uses Redash and why

Analysts and engineers who write SQL and want to share the results with the rest of their organisation.

Redash connects to many data sources. Users write SQL and other queries in the browser, turn the results into visualisations and dashboards, schedule refreshes and set alerts.

A typical use: An analyst keeps answering the same questions about weekly sign-ups. In Redash she writes the query once, charts it, adds it to a team dashboard that refreshes on a schedule, and sets an alert that notifies her when sign-ups fall below an expected level.

From the upstream project's own description: https://github.com/getredash/redash.

## This release

- Docker Scout policy grade at release: **A** (94%), graded 2026-11-23 with `docker scout policy` (CLI 1.26.0, docker-default configuration).
  - Docker Scout counts 29 packages with copyleft licences (GPL, LGPL, MPL), 28 of them operating-system packages (it counts only packages whose licence it can read; the SBOM lists every component).
- Signed with ReadyStack's release key (fingerprint `04daa92344a52dbc`): https://readystack.dev/keys/cosign.pub.
- Runs as a non-root user (`redash`).
- Attestations on the image: an SPDX SBOM and SLSA provenance v1.
- Rebuilt from this kit with network egress blocked on 2026-11-23; the rebuilt image digest is the published one.
- Base: Ubuntu 24.04.

The current grade, measured again every day, is on https://readystack.dev/products/redash.

Redash is distributed under its upstream licence (BSD-2-Clause); the kit contains upstream's source under that licence, and each vendored component under its own.

## Download

From the [v26.9.0-CE-ubuntu24.04-r8 release](https://github.com/readystack-dev/redash/releases/tag/v26.9.0-CE-ubuntu24.04-r8): `ReadyStack-redash-v26.9.0-CE-ubuntu24.04-r8.tar.gz` (687.9 MB), SHA-256 `7c94db852826f3b1b9c9ba2090a924fb8fbe63b25bca648028649ec9c62192af`.

```sh
sha256sum --check --ignore-missing SHA256SUMS
```

## Verify and rebuild

The rebuild statement is signed with the ReadyStack release key. Check the signature before you rely on it:

```sh
cosign verify-blob --key https://readystack.dev/keys/cosign.pub \
  --bundle ReadyStack-redash-v26.9.0-CE-ubuntu24.04-r8.rebuild.json.sigstore ReadyStack-redash-v26.9.0-CE-ubuntu24.04-r8.rebuild.json
```

Unpack with `-p` so file modes are kept, then follow the kit's own README.md and docs/REBUILD.md:

```sh
tar -xpzf ReadyStack-redash-v26.9.0-CE-ubuntu24.04-r8.tar.gz
cd v26.9.0-CE-ubuntu24.04-r8
less README.md docs/REBUILD.md
```

The build trail (`ReadyStack-redash-v26.9.0-CE-ubuntu24.04-r8.trail.json`, signed the same way, and its Markdown copy) records how this release was built and checked.

## This repository

`recipe/` holds the kit's recipe files (Dockerfiles, build scripts, pins) as published at https://readystack.dev/products/redash/recipe. The complete kit is the release download. Each release is a tag here.

— ReadyStack · https://readystack.dev
