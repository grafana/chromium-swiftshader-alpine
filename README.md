# chromium-swiftshader-alpine

An alpine-based container image with `chromium-swiftshader` installed. This is released and tagged with the `chromium-swiftshader` version inside, which allow downstream packages that need chromium to pin this version safely.

## Using this image

This image is tagged as `ghcr.io/grafana/chromium-swiftshader-alpine:CHROMIUMVERSION-ALPINEVERSION`, with both versions grepped from the `Dockerfile`. As the image is tagged on every push to `main`, it is unlikely but possible for that tag to be overwritten if changes to CI/CD or similar are merged. It is recommended to pin the digest of it:

```Dockerfile
FROM ghcr.io/grafana/chromium-swiftshader-alpine:000.0.0000.00-r0-0.0.0@sha256:e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855
```

That way, dependency bumping bots will create PRs when the tag is overwritten.

## Updating the Chrome version

Renovate is set up to update [the Chrome version used to build the container
image](Dockerfile).

Should that process fail for some reason, you can verify [the version currently
available from the Alpine community repository][alpine-search]. Notice the
branch might need to be adjusted to reflect what's current. Notice as well that
currently we use `chromium-swiftshader`, **not** `chromium`.

Should there ever be a need to update this version by hand, update the
[Dockerfile](Dockerfile) and create a new release.

[alpine-search]: https://pkgs.alpinelinux.org/packages?name=chromium-swiftshader&branch=v3.23&repo=&arch=x86_64&origin=&flagged=&maintainer=
