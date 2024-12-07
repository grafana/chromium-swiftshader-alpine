# Renovate and CI/CD interact with the following line. Keep its format as it is.
ARG ALPINE_VERSION=3.21.0@sha256:21dc6063fd678b478f57c0e13f47560d0ea4eeba26dfc947b2a4f81f686b9f45

FROM alpine:${ALPINE_VERSION}

# Renovate and CI/CD interact with the following line. Keep its format as it is.
ARG CHROMIUM_VERSION=131.0.6778.108-r0
RUN apk add --no-cache "chromium-swiftshader=${CHROMIUM_VERSION}"
