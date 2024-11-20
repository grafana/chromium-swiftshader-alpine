# Renovate and CI/CD interact with the following line. Keep its format as it is.
ARG ALPINE_VERSION=3.20.3@sha256:1e42bbe2508154c9126d48c2b8a75420c3544343bf86fd041fb7527e017a4b4a

FROM alpine:${ALPINE_VERSION}

# Renovate and CI/CD interact with the following line. Keep its format as it is.
ARG CHROMIUM_VERSION=131.1.0-r2
RUN apk add --no-cache "chromium-swiftshader=${CHROMIUM_VERSION}"
