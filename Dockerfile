# syntax=docker/dockerfile:1.3
FROM renovate/renovate:37.46.0@sha256:4df83b9a55c12402697bfe644b8d0482a574483b3f0ef62954dc8712b2a371ad

LABEL org.opencontainers.image.source=https://github.com/nabeken/docker-renovate-github-apps \
  org.opencontainers.image.licenses="AGPL-3.0-only"

# renovate: datasource=github-releases depName=nabeken/go-github-apps
ENV GO_GITHUB_APPS_VERSION=v0.1.10

# run as root
USER 0

RUN set -eo pipefail; \
  cd /tmp; \
  curl -sSLf https://raw.githubusercontent.com/nabeken/go-github-apps/master/install-via-release.sh | bash -s -- -v ${GO_GITHUB_APPS_VERSION}; \
  cp go-github-apps /usr/local/bin;

# preserve the orinal entrypoint
RUN set -eo pipefail; \
  cp /usr/local/bin/docker-entrypoint.sh /usr/local/bin/orig-docker-entrypoint.sh

# override the base image
COPY src/ /

# setup the directories again to set the proper permissions
RUN set -eo pipefail; \
  . /usr/local/containerbase/util.sh; \
  setup_directories;

# run as user
# https://github.com/renovatebot/docker-renovate-full/blob/main/Dockerfile
USER 1000
