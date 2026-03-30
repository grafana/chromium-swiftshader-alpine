# chromium-swiftshader-alpine

Alpine container image providing headless Chromium with SwiftShader for downstream browser testing.

## Architecture

Three systems parse the Dockerfile ARG lines independently: Renovate custom regex managers extract versions to check for updates, CI greps the same lines to compose the image tag, and Docker uses them at build time. All three must agree on the line format.

## Gotchas

Alpine and Chromium versions must be bumped together. A Chromium package version that exists for one Alpine release may not exist for another, so splitting them into separate changes causes builds that fail only at install time with a cryptic package-not-found error.
