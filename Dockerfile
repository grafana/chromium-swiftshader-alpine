# Renovate and CI/CD interact with the following line. Keep its format as it is.
ARG ALPINE_VERSION=3.21.2@sha256:56fa17d2a7e7f168a043a2712e63aed1f8543aeafdcee47c58dcffe38ed51099

FROM alpine:${ALPINE_VERSION}

# Renovate and CI/CD interact with the following line. Keep its format as it is.
ARG CHROMIUM_VERSION=132.0.6834.83-r0
RUN apk add --no-cache "chromium-swiftshader=${CHROMIUM_VERSION}"
