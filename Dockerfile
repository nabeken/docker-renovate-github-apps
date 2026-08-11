# syntax=docker/dockerfile:1.26@sha256:ecfaec9ed6d810b56388c508f4121597bfbba70d41a6dfeee4d8cad5f295fc32
FROM renovate/renovate:44.23.3@sha256:818f93d52ee1bb05d56be9577a17ecbe049ccd0e8b3950f5b5ce6ef056c7265c

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
