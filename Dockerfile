# syntax=docker/dockerfile:1.12@sha256:db1ff77fb637a5955317c7a3a62540196396d565f3dd5742e76dddbb6d75c4c5
FROM renovate/renovate:39.61.1@sha256:c7ca3d131893b54dc733ba86040429f04ffa308f38a3ccef5c4b05b7902b6a22

LABEL org.opencontainers.image.source=https://github.com/nabeken/docker-renovate-github-apps \
  org.opencontainers.image.licenses="AGPL-3.0-only"

# renovate: datasource=github-releases depName=nabeken/go-github-apps
ENV GO_GITHUB_APPS_VERSION=v0.2.1

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
# https://github.com/renovatebot/docker-renovate-full/blob/main/Dockerfile
USER 1000
