# Provenance — Redash (`v26.9.0-CE-ubuntu24.04-r8`)

Every item below is copied from a record in this archive; the record is named in brackets.

## Source

- Upstream repository: https://github.com/getredash/redash
- Revision built: `v26.9.0` (commit `42fdf9d4a0fdb83841130ab78f69899a224f281b`)
- Source tree: `973cb2459034cd07deb972d5e4ede590ec4baf788e37a7b13356be9f19233577` over 1288 files [`docs/provenance/SOURCE_TREE_HASH.json`]
- Community Edition only: enterprise code is removed or refused before the build (CE audit at acquire).

## Build

- Method: `source-rebuild-python`; base image `scratch + a chiselled Ubuntu 24.04 runtime (vendored/chisel/slices.txt, packages.tsv)`
- Compiled with `--network=none` from vendored source, dependencies and base images; BuildKit pinned to `moby/buildkit:v0.31.2` (shipped in `toolchain/`).
- SOURCE_DATE_EPOCH: `1794458806` [`SOURCE_DATE_EPOCH.txt`]
- Frozen inputs: [`docs/provenance/FREEZE_MANIFEST.json`], build recipe: [`docs/provenance/BUILD_RECIPE.json`].

## Output

- Published image: `readystack/redash:v26.9.0-CE-ubuntu24.04-r8` — index digest `sha256:7a5124cf1c1847b8b7070ea4098c99bb41e2c1b07a1e9a009ea924ac8631fb5f` [`docs/provenance/LOCKED_DIGEST.txt`]
- linux/amd64 image digest `sha256:a6e4f54c6e668de2218297d6784084885c47e7c17cb92b3bafddc0cd9bd09109` — reproduced from this archive before publishing [`docs/provenance/REPRO_VERIFICATION.json`].

## Attestations and signature

- SBOM + SLSA provenance attached to the image: attached: an SPDX SBOM and SLSA v1 provenance [`docs/provenance/SCOUT_VERDICT.json`]
- cosign signature by the ReadyStack release key: verified before publishing. Check it: `cosign verify --key https://readystack.dev/keys/cosign.pub readystack/redash:v26.9.0-CE-ubuntu24.04-r8`

## Pinned inputs, and why

- 27 pinned inputs, each with where it came from, why this one, how it was checked and when it was decided: `docs/PINS.md` [`docs/provenance/PINS.json`] (upstream source 2, base and build images 2, image digests 3, language runtimes and toolchains 1, pins in the kit's dockerfiles 8, readystack's build engine 5, dependencies upstream chose 2, services the release checks run beside 4).

## Build trail

- How this release passed through the ReadyStack harness, record by record (every chain, drive, stage, review round, defect and check, each naming the record it is copied from): `ReadyStack-redash-v26.9.0-CE-ubuntu24.04-r8.trail.json`, published beside this archive and signed with the release key (`ReadyStack-redash-v26.9.0-CE-ubuntu24.04-r8.trail.json.sigstore`), and readable at https://readystack.dev/products/redash/trail/v26.9.0-CE-ubuntu24.04-r8.

