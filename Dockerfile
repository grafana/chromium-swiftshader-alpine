# Renovate and CI/CD interact with the following line. Keep its format as it is.
ARG ALPINE_VERSION=3.23.4@sha256:5b10f432ef3da1b8d4c7eb6c487f2f5a8f096bc91145e68878dd4a5019afde11

FROM alpine:${ALPINE_VERSION}

RUN apk add --no-cache font-noto font-noto-cjk

# Renovate and CI/CD interact with the following line. Keep its format as it is.
ARG CHROMIUM_VERSION=147.0.7727.55-r0
RUN apk add --no-cache "chromium=${CHROMIUM_VERSION}" "chromium-swiftshader=${CHROMIUM_VERSION}"

# Build time check, asserting chromium binary is installed and sane
RUN chromium --version
