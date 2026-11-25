# Redash v26.9.0 — ReadyStack release `v26.9.0-CE-ubuntu24.04-r8`

Generated 2026-11-23 from this release's build records and strategy. Statements that come from a single record name it in brackets; the others come from this release's strategy and build log.

## Release

- **Image:** `readystack/redash:v26.9.0-CE-ubuntu24.04-r8` (linux/amd64). Index digest `sha256:7a5124cf1c1847b8b7070ea4098c99bb41e2c1b07a1e9a009ea924ac8631fb5f` [`docs/provenance/LOCKED_DIGEST.txt`].
- **Image manifest digest:** `sha256:a6e4f54c6e668de2218297d6784084885c47e7c17cb92b3bafddc0cd9bd09109` [`TARGET_DIGEST.txt`].
- **Upstream:** Redash v26.9.0 built from source at `v26.9.0` of https://github.com/getredash/redash — upstream notes: https://github.com/getredash/redash/releases/tag/v26.9.0 [`docs/provenance/BUILD_RECIPE.json`].
- **Base image:** none (`FROM scratch`): a chiselled Ubuntu 24.04 runtime, the files Canonical's chisel cut from Ubuntu's own packages (`vendored/chisel/slices.txt`, `vendored/chisel/packages.tsv`); runtime user `redash`.
- **Build:** `source-rebuild-python`, compiled offline with `--network=none`.
- **Supersedes:** ReadyStack release `v26.9.0-CE-ubuntu24.04-r6`.

## What changed in this release

- Upstream version unchanged (v26.9.0); ReadyStack rebuild.
- Redash v26.9.0 is unchanged from the release this supersedes (v26.9.0-CE-ubuntu24.04-r6); this release rebuilds it on a slim base. Changes: the image no longer starts from the full ubuntu:24.04 image. It is built FROM scratch with a chiselled Ubuntu 24.04 runtime: only the files that Canonical's chisel cut from a few Ubuntu packages (base-files, base-passwd, ca-certificates, tzdata, the dash shell, bash for the entrypoint, part of coreutils, the libraries the compiled CPython 3.13.18 loads, unixODBC's libodbc2 for pyodbc, the libraries ibm_db's DB2 client loads, and the libraries they need; the list is vendored/chisel/packages.tsv in the release archive). The image has /bin/sh and bash but no curl, wget, openssl or package manager (apt, dpkg), and still defines no Docker HEALTHCHECK; send the documented curl requests from the host. Redash, the entrypoint and its first-start steps, supervisord and the programs it runs, port 5000, the environment variables and the runtime user (redash, uid 1000, gid 999) are those of v26.9.0-CE-ubuntu24.04-r6: replace the container with this image against the same PostgreSQL and Redis. Release v26.9.0-CE-ubuntu24.04-r7 (a rebuild for USN-9006-1, perl-base 5.38.2-3.2ubuntu0.7) was prepared but never released; this release replaces it, and has no perl at all.

## Security status at release (measured 2026-11-23)

- **Docker Scout:** 0 fixable critical/high vulnerabilities; runs as `redash` (non-root); SBOM + provenance attestations present (SPDX SBOM + SLSA v1) [`docs/provenance/SCOUT_VERDICT.json`].
- **OSV cross-check:** no fixable critical/high vulnerability beyond Docker Scout's findings.
- **Signature:** cosign signature verified by ReadyStack's release gate before publishing; check it yourself with `cosign verify --key https://readystack.dev/keys/cosign.pub readystack/redash:v26.9.0-CE-ubuntu24.04-r8` (signatures are recorded in the public Sigstore transparency log).
- **ReadyStack release check at release:** passed (ReadyStack's own test, not a Docker Scout grade). Vulnerabilities are disclosed every day and the image never changes, so it is re-checked daily, beside Docker Scout's own dated grade, at https://readystack.dev/queue.
- **Before exposing this service:** The /setup page creates the administrator for whoever reaches it first. Complete setup before the port is reachable by others.

## Reproducibility

Rebuilds offline from this archive to the identical image digest `sha256:a6e4f54c6e668de2218297d6784084885c47e7c17cb92b3bafddc0cd9bd09109`: run `./BUILD_OFFLINE.sh`, then `./VERIFY_OFFLINE.sh` (add `--online` to confirm the Docker Hub tag holds the same digest). Before publishing, ReadyStack rebuilt the kit with `./BUILD_OFFLINE.sh` and compared the result with the published digest [`docs/provenance/REPRO_VERIFICATION.json`], then ran `./BUILD_OFFLINE.sh` and `./VERIFY_OFFLINE.sh` from this archive (without `--online`).

## Validation

- 2 of 2 use cases passed (2 authored) against the running image [`docs/validation/test-results.json`].
- The cases are `GET /ping` (200), `GET /setup` (200); the suite checks nothing else.

## Known issues

- **high** (upstream): First visitor can claim the administrator account until setup is completed [`RSD-redash-2940920c8c`]

## Verify this archive

```
sha256sum -c CHECKSUMS.sha256
./BUILD_OFFLINE.sh && ./VERIFY_OFFLINE.sh --online
cosign verify --key https://readystack.dev/keys/cosign.pub readystack/redash:v26.9.0-CE-ubuntu24.04-r8
```

ReadyStack records every signature in the public Sigstore transparency log (Rekor), so the command needs no extra flags.

