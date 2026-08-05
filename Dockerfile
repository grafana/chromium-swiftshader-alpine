# Renovate and CI/CD interact with the following line. Keep its format as it is.
ARG ALPINE_VERSION=3.24.1@sha256:28bd5fe8b56d1bd048e5babf5b10710ebe0bae67db86916198a6eec434943f8b

FROM alpine:${ALPINE_VERSION}

RUN apk add --no-cache font-noto font-noto-cjk

# Renovate and CI/CD interact with the following line. Keep its format as it is.
ARG CHROMIUM_VERSION=149.0.7827.53-r0
RUN apk add --no-cache "chromium=${CHROMIUM_VERSION}" "chromium-swiftshader=${CHROMIUM_VERSION}"

# Build time check, asserting chromium binary is installed and sane
RUN chromium --version
