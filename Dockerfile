# syntax=docker/dockerfile:1.26@sha256:ecfaec9ed6d810b56388c508f4121597bfbba70d41a6dfeee4d8cad5f295fc32
FROM renovate/renovate:44.48.3@sha256:f7d104f9130bd96d22ea5d5310a752d0752c2a431bfeae4a01257d0a4efc3c20

LABEL org.opencontainers.image.source=https://github.com/nabeken/docker-renovate-github-apps \
  org.opencontainers.image.licenses="AGPL-3.0-only"

# renovate: datasource=github-releases depName=nabeken/go-github-apps
ENV GO_GITHUB_APPS_VERSION=v0.2.6

# run as root
USER 0

RUN set -eo pipefail; \
  cd /tmp; \
  curl -sSLf https://raw.githubusercontent.com/nabeken/go-github-apps/master/install-via-release.sh | bash -s -- -v ${GO_GITHUB_APPS_VERSION}; \
  cp go-github-apps /usr/local/bin;

# preserve the orinal entrypoint
RUN set -eo pipefail; \
  cp /usr/local/sbin/renovate-entrypoint.sh /usr/local/sbin/orig-renovate-entrypoint.sh

# override the base image
COPY src/ /

# run as user
# https://github.com/renovatebot/renovate/blob/main/tools/docker/Dockerfile
USER 12021
