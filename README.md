# Docker cache layer

This project is a demo for caching docker layer using DOCKER_BUILDKIT to increase build time.
Basic, it consists using dockerfile with multistage.

## Running

```sh

export REPO=rpolnx
export PROJECT_REPONAME=docker-nest-cache
export LATEST_TAG=latest
export IMAGE_TAG=$(git rev-parse HEAD)

export DOCKER_BUILDKIT=1


./deploy.sh # CI basic example

```
