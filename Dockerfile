# Renovate and CI/CD interact with the following line. Keep its format as it is.
ARG ALPINE_VERSION=3.23.3@sha256:25109184c71bdad752c8312a8623239686a9a2071e8825f20acb8f2198c3f659

FROM alpine:${ALPINE_VERSION}

RUN apk add --no-cache font-noto font-noto-cjk

# Renovate and CI/CD interact with the following line. Keep its format as it is.
ARG CHROMIUM_VERSION=144.0.7559.132-r1
RUN apk add --no-cache "chromium=${CHROMIUM_VERSION}" "chromium-swiftshader=${CHROMIUM_VERSION}"

# Build time check, asserting chromium binary is installed and sane
RUN chromium --version
