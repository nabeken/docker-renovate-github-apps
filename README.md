# docker-renovate-github-apps

`docker-renovate-github-apps` is a container image to run [the official Renovate image](https://github.com/renovatebot/docker-renovate/tree/main) with Github Apps Installation Token.

## How It Works

If there are the following three environment variables found, an entrypoint script will invoke `go-github-apps` command prior to invoking the original entrypoint. Renovate will be result in using Github Apps Installation Token.

- `GO_GITHUB_APPS_APP_ID`: Github Apps ID
- `GO_GITHUB_APPS_INST_ID`: Github Apps Installation ID of the app
- `GITHUB_PRIV_KEY`: Github Apps' private key to request an Installation token

For more details, please visit https://github.com/nabeken/go-github-apps

## Usage in Github Actions

TBD

## Build

```
make build
```
