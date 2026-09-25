# Renovate and CI/CD interact with the following line. Keep its format as it is.
ARG ALPINE_VERSION=3.24.2@sha256:294b683cb724975bec92580e1e685676bd4b50bda910ddb8c51d4cabeaec77e6

FROM alpine:${ALPINE_VERSION}

RUN apk add --no-cache font-noto font-noto-cjk

# Renovate and CI/CD interact with the following line. Keep its format as it is.
ARG CHROMIUM_VERSION=152.0.7977.82-r1
# chromium-swiftshader r1 (musl stack-limit fix, aports@a4485411) fixes CVE-2026-87534,
# CVE-2026-87544, CVE-2026-87595, CVE-2026-87643, CVE-2026-87646, CVE-2026-87650.
# Not yet backported to v3.24 stable community. Enabling edge here pulls chromium's
# full dependency chain from edge too (~65 packages, incl. libgcc/libstdc++/glib/mesa) -
# apk resolves against whatever build toolchain upstream aports used for r1, it does not
# stay scoped to just these two packages. Accepted deliberately: the CRITICAL CVE fix
# outweighs the edge-dependency risk. Revert to r0 (stable-only) once r1 lands on v3.24.
RUN printf 'https://dl-cdn.alpinelinux.org/alpine/edge/main\nhttps://dl-cdn.alpinelinux.org/alpine/edge/community\n' >> /etc/apk/repositories \
	&& apk update \
	&& apk add --no-cache "chromium=${CHROMIUM_VERSION}" "chromium-swiftshader=${CHROMIUM_VERSION}" \
	&& sed -i '\#/alpine/edge/#d' /etc/apk/repositories \
	&& apk update

# Build time check, asserting chromium binary is installed and sane
RUN chromium --version
