# Renovate and CI/CD interact with the following line. Keep its format as it is.
ARG ALPINE_VERSION=edge

FROM alpine:${ALPINE_VERSION}

RUN apk add --no-cache font-noto font-noto-cjk

# Renovate and CI/CD interact with the following line. Keep its format as it is.
ARG CHROMIUM_VERSION=137.0.7151.103-r0
RUN apk add --no-cache "chromium-swiftshader=${CHROMIUM_VERSION}"
