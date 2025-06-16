# syntax=docker/dockerfile:1.16@sha256:e2dd261f92e4b763d789984f6eab84be66ab4f5f08052316d8eb8f173593acf7
FROM renovate/renovate:40.58.0@sha256:223864b3a87c1cd54800d9ea6046a7cedcd88734aaf2dcc2c3a816ba3b446b0c

LABEL org.opencontainers.image.source=https://github.com/nabeken/docker-renovate-github-apps \
  org.opencontainers.image.licenses="AGPL-3.0-only"

# renovate: datasource=github-releases depName=nabeken/go-github-apps
ENV GO_GITHUB_APPS_VERSION=v0.2.4

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
