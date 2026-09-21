# Renovate and CI/CD interact with the following line. Keep its format as it is.
ARG ALPINE_VERSION=3.24.2@sha256:294b683cb724975bec92580e1e685676bd4b50bda910ddb8c51d4cabeaec77e6

FROM alpine:${ALPINE_VERSION}

RUN apk add --no-cache font-noto font-noto-cjk

# Renovate and CI/CD interact with the following line. Keep its format as it is.
ARG CHROMIUM_VERSION=152.0.7977.82-r0
RUN apk add --no-cache "chromium=${CHROMIUM_VERSION}" "chromium-swiftshader=${CHROMIUM_VERSION}"

# Build time check, asserting chromium binary is installed and sane
RUN chromium --version
