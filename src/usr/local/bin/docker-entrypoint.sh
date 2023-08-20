#!/bin/bash
ORIG_ENTRYPOINT=/usr/local/bin/orig-docker-entrypoint.sh
ENABLE_GO_GITHUB_APPS=true

if [ -z "${GO_GITHUB_APPS_APP_ID}" ]; then
  echo "WARN: GO_GITHUB_APPS_APP_ID is mising" >&2
  ENABLE_GO_GITHUB_APPS=false
fi

if [ -z "${GO_GITHUB_APPS_INST_ID}" ]; then
  echo "WARN: GO_GITHUB_APPS_INST_ID is mising" >&2
  ENABLE_GO_GITHUB_APPS=false
fi

if [ -z "${GITHUB_PRIV_KEY}" ]; then
  echo "WARN: GITHUB_PRIV_KEY is mising" >&2
  ENABLE_GO_GITHUB_APPS=false
fi

if ${ENABLE_GO_GITHUB_APPS}; then
  echo "Exporting GITHUB_TOKEN to /usr/local/etc/env..." >&2
  eval "$(go-github-apps -export -app-id "${GO_GITHUB_APPS_APP_ID}" -inst-id "${GO_GITHUB_APPS_INST_ID}")"
else
  echo "WARN: go-github-apps won't run because there are missing environment variables" >&2
fi

if [ $? -ne 0 ]; then
  exit 1
fi

if [ -f "${ORIG_ENTRYPOINT}" ]; then
  exec "${ORIG_ENTRYPOINT}" "${@}"
else
  echo "ERROR: no ${ORIG_ENTRYPOINT} found" >&2
  exit 1
fi
