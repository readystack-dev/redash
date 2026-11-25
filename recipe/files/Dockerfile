# Redash v26.9.0 (BSD-2-Clause) HERMETIC OFFLINE BUILD. --network=none.
# CPython 3.13.18 COMPILED HERE, offline (--network=none), from python.org's tarball (sha256 re-checked) and
# the vendored build debs, by the same command the vendor stage ran; linked against Ubuntu's libraries.
FROM ubuntu:24.04@sha256:9c7f200c07e3d4a03e7249d2c16bf66a51120fb876aa2242cf31451412543289 AS cpython
ARG SOURCE_DATE_EPOCH=1794458806
ENV SOURCE_DATE_EPOCH=${SOURCE_DATE_EPOCH}
COPY vendored/redash-src/python/debs/ /tmp/cpython-debs/
COPY vendored/redash-src/python/Python-3.13.18.tar.xz /tmp/Python-3.13.18.tar.xz
RUN set --; for f in /tmp/cpython-debs/*.deb; do [ -e "$f" ] && set -- "$@" "$f"; done; \
    for pass in 1 2 3 4 5; do [ $# -eq 0 ] || dpkg -i --skip-same-version "$@" >/dev/null 2>&1 && break; done; \
    dpkg --configure -a && bad= && for d in "$@"; do p=$(dpkg-deb -f "$d" Package) v=$(dpkg-deb -f "$d" Version); \
      case "$(dpkg-query -W -f='${Version} ${db:Status-Abbrev}' "$p" 2>/dev/null)" in "$v ii"*) ;; *) bad="$bad $p=$v" ;; esac; done && \
    { [ -z "$bad" ] || { echo "vendored debs not installed at their vendored version:$bad" >&2; false; }; } && \
    : "${SOURCE_DATE_EPOCH:?the CPython build needs SOURCE_DATE_EPOCH}" && \
    echo "abb0102e6d4ae027509bcb82327d9dd85515b44a3ba8ad538cfc5e9847029f68  /tmp/Python-3.13.18.tar.xz" | sha256sum -c - && \
    mkdir -p /usr/src/python && tar -xJf /tmp/Python-3.13.18.tar.xz -C /usr/src/python --strip-components=1 --no-same-owner && \
    rm -rf /tmp/cpython-debs /tmp/Python-3.13.18.tar.xz && cd /usr/src/python && \
    export DEB_BUILD_MAINT_OPTIONS=optimize=-lto && \
    PYCF="$(dpkg-buildflags --get CFLAGS) $(dpkg-buildflags --get CPPFLAGS)" && PYLD="$(dpkg-buildflags --get LDFLAGS)" && \
    ./configure --build=x86_64-linux-gnu --prefix=/usr/local --enable-shared --enable-loadable-sqlite-extensions --enable-option-checking=fatal --disable-test-modules --without-static-libpython --with-ensurepip=install --with-system-expat --without-system-libmpdec --with-dbmliborder= py_cv_module__dbm=n/a py_cv_module__gdbm=n/a py_cv_module__tkinter=n/a && \
    make -j"$(nproc)" "EXTRA_CFLAGS=$PYCF" "LDFLAGS=$PYLD,--strip-all" && \
    rm python && make -j"$(nproc)" "EXTRA_CFLAGS=$PYCF" "LDFLAGS=$PYLD,--strip-all,-rpath='\$\$ORIGIN/../lib'" python && \
    make install COMPILEALL_OPTS=--invalidation-mode=checked-hash && \
    cd / && rm -rf /usr/src/python /usr/local/lib/python3.13/idlelib /usr/local/lib/python3.13/tkinter /usr/local/lib/python3.13/turtledemo /usr/local/bin/idle3* && \
    for s in pip3 pydoc3 python3 python3-config; do ln -sfT "$s" "/usr/local/bin/${s%3*}${s#*3}"; done && \
    ldconfig && /usr/local/bin/python3 -I -B -c "import ssl, sqlite3, zlib, bz2, lzma, ctypes, uuid, pyexpat, decimal, readline, curses, hashlib, sys, importlib.util as u; bad = [m for m in ('_dbm', '_gdbm', '_tkinter') if u.find_spec(m)]; assert not bad, ('built but must not be', bad); print(sys.version.replace(chr(10), ' '), '|', ssl.OPENSSL_VERSION, '| sqlite', sqlite3.sqlite_version, '| expat', pyexpat.EXPAT_VERSION)" && \
    ldd /usr/local/lib/python3.13/lib-dynload/_ssl.cpython-*.so | grep -qE 'libssl.so.3 => /(usr/)?lib/x86_64-linux-gnu/' && ldd /usr/local/lib/python3.13/lib-dynload/_sqlite3.cpython-*.so | grep -qE 'libsqlite3.so.0 => /(usr/)?lib/x86_64-linux-gnu/' && ldd /usr/local/lib/python3.13/lib-dynload/pyexpat.cpython-*.so | grep -qE 'libexpat.so.1 => /(usr/)?lib/x86_64-linux-gnu/' && ldd /usr/local/lib/python3.13/lib-dynload/_ctypes.cpython-*.so | grep -qE 'libffi.so.8 => /(usr/)?lib/x86_64-linux-gnu/' && ldd /usr/local/lib/python3.13/lib-dynload/_lzma.cpython-*.so | grep -qE 'liblzma.so.5 => /(usr/)?lib/x86_64-linux-gnu/' && ldd /usr/local/lib/python3.13/lib-dynload/_bz2.cpython-*.so | grep -qE 'libbz2.so.1.0 => /(usr/)?lib/x86_64-linux-gnu/' && ldd /usr/local/lib/python3.13/lib-dynload/_uuid.cpython-*.so | grep -qE 'libuuid.so.1 => /(usr/)?lib/x86_64-linux-gnu/' && ldd /usr/local/lib/python3.13/lib-dynload/zlib.cpython-*.so | grep -qE 'libz.so.1 => /(usr/)?lib/x86_64-linux-gnu/'

# ---- pyrt: the Python runtime tree for the chiselled rootfs. The compiled CPython (above) with the vendored
#      site-packages, the venv and the application laid over it. pip is build-only (CVE-2026-8643 et al.): the
#      compile's ensurepip copy and the venv's go, and the build fails if either python can still import pip.

# ---- pyrt: the Python runtime tree for the chiselled rootfs. The compiled CPython (above) with the vendored
#      site-packages, the venv and the application laid over it. pip is build-only (CVE-2026-8643 et al.): the
#      compile's ensurepip copy and the venv's go, and the build fails if either python can still import pip.

# ---- pyrt: the Python runtime tree for the chiselled rootfs. The compiled CPython (above) with the vendored
#      site-packages, the venv and the application laid over it. pip is build-only (CVE-2026-8643 et al.): the
#      compile's ensurepip copy and the venv's go, and the build fails if either python can still import pip.
FROM cpython AS pyrt
ADD vendored/redash-src/site.tar.gz /
ADD vendored/redash-src/app.tar.gz /
RUN set -eu; rm -rf /usr/local/lib/python3.13/site-packages/pip /usr/local/lib/python3.13/site-packages/pip-*.dist-info /usr/local/bin/pip /usr/local/bin/pip3 /usr/local/bin/pip3.13 \
           /opt/venv/lib/python3.13/site-packages/pip /opt/venv/lib/python3.13/site-packages/pip-*.dist-info /opt/venv/bin/pip /opt/venv/bin/pip3 /opt/venv/bin/pip3.13; \
    for py in /usr/local/bin/python3 /opt/venv/bin/python; do \
      if "$py" -c 'import pip' 2>/dev/null; then echo "pip is still importable by $py" >&2; exit 1; fi; \
    done

# ---- rs-probe: the HTTP probe the build's health check and doc probes run (standard library only, from the kit's
#      rs-probe.go; the image has no curl). The Go image is the newest patch of gen_dockerfile.RS_PROBE_BUILDER's
#      line, as a chiselled Python kit's builder has no Go.
FROM golang:1.27.4-bookworm@sha256:4fa7c968ba93f1635670522dbb01a2c78150443e1385746924566079f36570ea AS build_rs_probe
WORKDIR /probe
COPY rs-probe.go main.go
COPY rs-probe.mod go.mod
ENV CGO_ENABLED=0 GOTOOLCHAIN=local GOFLAGS="-buildvcs=false" GOPROXY=off SOURCE_DATE_EPOCH=1794458806
RUN go build -trimpath -ldflags='-s -w' -o /rs-probe .

# ---- rootfs: the chiselled Ubuntu 24.04 runtime (vendored/chisel, cut by Dockerfile.vendor's chiselcut stage from
#      Ubuntu's own .debs), the service user, the Python trees and the kit's scripts, laid out on the pinned base.
#      Only /rootfs reaches the image. The cut's own dynamic loader, under chroot, must load every ELF file of the
#      trees (gen_dockerfile.chisel_load_check): a library the slices miss fails the build, not the first start.
FROM ubuntu:24.04@sha256:9c7f200c07e3d4a03e7249d2c16bf66a51120fb876aa2242cf31451412543289 AS rootfs
ARG SOURCE_DATE_EPOCH=1794458806
ADD vendored/chisel/rootfs.tar /rootfs/
RUN printf 'redash:x:1000:999::/home/redash:/bin/sh\n' >> /rootfs/etc/passwd && \
    printf 'redash:x:999:\n' >> /rootfs/etc/group && \
    mkdir -p /rootfs/home/redash /rootfs/etc/supervisor
COPY --from=build_rs_probe /rs-probe /rootfs/usr/local/bin/rs-probe
COPY --from=pyrt /usr/local/ /rootfs/usr/local/
COPY --from=pyrt /opt/venv/ /rootfs/opt/venv/
COPY --from=pyrt /app/ /rootfs/app/
COPY entrypoint-aio.sh /rootfs/usr/local/bin/entrypoint-aio.sh
COPY supervisor-redash.conf /rootfs/etc/supervisor/redash.conf
RUN chmod 755 /rootfs/usr/local/bin/rs-probe && \
    chmod 0755 /rootfs/usr/local/bin/entrypoint-aio.sh && \
    chown -R 1000:999 /rootfs/app /rootfs/home/redash
RUN set -eu; find /rootfs/usr/local /rootfs/opt/venv /rootfs/app -type f | LC_ALL=C sort | while read -r f; do \
      [ "$(od -An -c -N4 "$f" | tr -d ' ')" = 177ELF ] || continue; \
      chroot /rootfs /usr/bin/env LD_TRACE_LOADED_OBJECTS=1 /lib64/ld-linux-x86-64.so.2 "${f#/rootfs}" 2>&1 | sed -n 's/^[[:space:]]*\([^[:space:]]*\) => not found.*/\1/p; s/.*error while loading shared libraries: \([^:]*\): cannot open.*/\1/p; s/^[[:space:]]*libc\.so\.6 => \/.*/ traced/p'; \
    done > /tmp/ldtrace; \
    [ "$(grep -c '^ traced$' /tmp/ldtrace)" -gt 0 ] || { echo "the cut's ld.so traced no ELF file under /usr/local /opt/venv /app" >&2; exit 1; }; \
    grep -v '^ traced$' /tmp/ldtrace | LC_ALL=C sort -u > /tmp/unresolved || :; \
    while read -r lib; do [ -n "$(find /rootfs/usr/local /rootfs/opt/venv /rootfs/app -name "$lib" -print -quit)" ] || echo "$lib"; done < /tmp/unresolved > /tmp/missing; \
    [ ! -s /tmp/missing ] || { echo "the chiselled rootfs cannot load $(tr '\n' ' ' < /tmp/missing)(ld.so under chroot): add their slices to runtime_base.slices" >&2; exit 1; }; \
    echo "$(grep -c '^ traced$' /tmp/ldtrace) ELF files under /usr/local /opt/venv /app load in the chiselled rootfs (resolved inside the trees only: $(tr '\n' ' ' < /tmp/unresolved))"; rm -f /tmp/ldtrace /tmp/unresolved /tmp/missing
# The scanners' inputs must be in the image: /etc/os-release and a dpkg status that names every package of the cut
# (chisel writes none; Dockerfile.vendor generates it). The wall-clock and host-derived paths go.
RUN --mount=type=bind,source=vendored/chisel,target=/chisel set -eu; \
    [ -e /rootfs/etc/os-release ] || { echo "no /etc/os-release: base-files_release-info is missing" >&2; exit 1; }; \
    [ "$(grep -c '^Package: ' /rootfs/var/lib/dpkg/status)" = "$(wc -l < /chisel/packages.tsv)" ] || \
      { echo "/var/lib/dpkg/status does not list every package of vendored/chisel/packages.tsv" >&2; exit 1; }; \
    rm -rf /rootfs/var/log/dpkg.log /rootfs/var/log/alternatives.log /rootfs/var/log/apt /rootfs/var/cache/ldconfig/aux-cache /rootfs/var/cache/fontconfig

FROM scratch
ARG SOURCE_DATE_EPOCH=1794458806
COPY --from=rootfs /rootfs/ /
ENV PATH=/opt/venv/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin LANG=C.UTF-8 PYTHONDONTWRITEBYTECODE=1 PYTHONUNBUFFERED=1 REDASH_VERSION_CHECK=false
WORKDIR /app
USER redash
EXPOSE 5000
ENTRYPOINT ["/usr/local/bin/entrypoint-aio.sh"]
# >>> readystack OCI labels: strategies/redash.json image_labels plus the standard OCI labels,
# the set a generated kit carries (gen_dockerfile.label_lines). Written by scripts/kit_migrations.py;
# scripts/retarget.py re-renders it with every retarget. Never edit it by hand.
LABEL org.opencontainers.image.title="Redash"
LABEL org.opencontainers.image.version="v26.9.0-CE-ubuntu24.04-r8"
LABEL org.opencontainers.image.licenses="BSD-2-Clause"
LABEL org.opencontainers.image.source="https://github.com/getredash/redash"
LABEL org.opencontainers.image.description="Redash — the BSD-licensed open-source data visualization and dashboarding platform (Flask + RQ)."
LABEL org.opencontainers.image.vendor="Redash"
LABEL org.opencontainers.image.revision="42fdf9d4a0fdb83841130ab78f69899a224f281b"
# <<< readystack OCI labels
