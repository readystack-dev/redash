# Redash v26.9.0 — ReadyStack release `v26.9.0-CE-ubuntu24.04-r9`

Generated 2026-11-28 from this release's build records and strategy. Statements that come from a single record name it in brackets; the others come from this release's strategy and build log.

## Release

- **Image:** `readystack/redash:v26.9.0-CE-ubuntu24.04-r9` (linux/amd64). Index digest `sha256:87904485d84d7510db37c4a2d9536c1fc5b3bf5462e3307f0aaa66c19a02f8ee` [`docs/provenance/LOCKED_DIGEST.txt`].
- **Image manifest digest:** `sha256:be72659ca516427f35f270ae1a6217a822bbb0a0b9bf3c501d6eba772651e154` [`TARGET_DIGEST.txt`].
- **Upstream:** Redash v26.9.0 built from source at `v26.9.0` of https://github.com/getredash/redash — upstream notes: https://github.com/getredash/redash/releases/tag/v26.9.0 [`docs/provenance/BUILD_RECIPE.json`].
- **Base image:** none (`FROM scratch`): a chiselled Ubuntu 24.04 runtime, the files Canonical's chisel cut from Ubuntu's own packages (`vendored/chisel/slices.txt`, `vendored/chisel/packages.tsv`); runtime user `redash`.
- **Build:** `source-rebuild-python`, compiled offline with `--network=none`.
- **Supersedes:** ReadyStack release `v26.9.0-CE-ubuntu24.04-r8`.

## What changed in this release

- Upstream version unchanged (v26.9.0); ReadyStack rebuild.
- Redash v26.9.0 is unchanged from the release this supersedes (v26.9.0-CE-ubuntu24.04-r8); this release rebuilds it. Changes: libexpat1 moves from 2.6.1-2ubuntu0.6 to 2.6.1-2ubuntu0.7 (USN-9196-1). Settings, ports and data volumes are those of v26.9.0-CE-ubuntu24.04-r8: replace the container with this image on the same volumes.

## Security status at release (measured 2026-11-28)

- **Docker Scout:** 0 fixable critical/high vulnerabilities; runs as `redash` (non-root); SBOM + provenance attestations present (SPDX SBOM + SLSA v1) [`docs/provenance/SCOUT_VERDICT.json`].
- **OSV cross-check:** no fixable critical/high vulnerability beyond Docker Scout's findings.
- **Signature:** cosign signature verified by ReadyStack's release gate before publishing; check it yourself with `cosign verify --key https://readystack.dev/keys/cosign.pub readystack/redash:v26.9.0-CE-ubuntu24.04-r9` (signatures are recorded in the public Sigstore transparency log).
- **ReadyStack release check at release:** passed (ReadyStack's own test, not a Docker Scout grade). Vulnerabilities are disclosed every day and the image never changes, so it is re-checked daily, beside Docker Scout's own dated grade, at https://readystack.dev/queue.
- **Before exposing this service:** The /setup page creates the administrator for whoever reaches it first. Complete setup before the port is reachable by others.

## Reproducibility

Rebuilds offline from this archive to the identical image digest `sha256:be72659ca516427f35f270ae1a6217a822bbb0a0b9bf3c501d6eba772651e154`: run `./BUILD_OFFLINE.sh`, then `./VERIFY_OFFLINE.sh` (add `--online` to confirm the Docker Hub tag holds the same digest). Before publishing, ReadyStack rebuilt the kit with `./BUILD_OFFLINE.sh` and compared the result with the published digest [`docs/provenance/REPRO_VERIFICATION.json`], then ran `./BUILD_OFFLINE.sh` and `./VERIFY_OFFLINE.sh` from this archive (without `--online`).

## Validation

- 2 of 2 use cases passed (2 authored) against the running image [`docs/validation/test-results.json`].
- The cases are `GET /ping` (200), `GET /setup` (200); the suite checks nothing else.

## Known issues

- **high** (upstream): First visitor can claim the administrator account until setup is completed [`RSD-redash-41acccdbb7`]

## Verify this archive

```
sha256sum -c CHECKSUMS.sha256
./BUILD_OFFLINE.sh && ./VERIFY_OFFLINE.sh --online
cosign verify --key https://readystack.dev/keys/cosign.pub readystack/redash:v26.9.0-CE-ubuntu24.04-r9
```

ReadyStack records every signature in the public Sigstore transparency log (Rekor), so the command needs no extra flags.

