# Renovate and CI/CD interact with the following line. Keep its format as it is.
ARG ALPINE_VERSION=3.22.2@sha256:4b7ce07002c69e8f3d704a9c5d6fd3053be500b7f1c69fc0d80990c2ad8dd412

FROM alpine:${ALPINE_VERSION}

RUN apk add --no-cache font-noto font-noto-cjk

# Renovate and CI/CD interact with the following line. Keep its format as it is.
ARG CHROMIUM_VERSION=142.0.7444.59-r0
RUN apk add --no-cache "chromium-swiftshader=${CHROMIUM_VERSION}"
