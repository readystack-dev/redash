# Redash: ReadyStack build kit

The offline build kit for the Docker image `readystack/redash:v26.9.0-CE-ubuntu24.04-r8`. It holds what the image is built from (upstream source, base images, toolchain, pinned dependencies) and the documents, so the image can be rebuilt with no network access (`docker build --network=none`).

- Release: [v26.9.0-CE-ubuntu24.04-r8](https://github.com/readystack-dev/redash/releases/tag/v26.9.0-CE-ubuntu24.04-r8)
- Image: [`docker.io/readystack/redash:v26.9.0-CE-ubuntu24.04-r8`](https://hub.docker.com/r/readystack/redash/tags), manifest digest `sha256:a6e4f54c6e668de2218297d6784084885c47e7c17cb92b3bafddc0cd9bd09109`
- Product page: https://readystack.dev/products/redash
- Defects: this repository's Issues (defects recorded from 25 November 2026 on) and https://readystack.dev/defects.html?product=redash

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
