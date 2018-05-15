#!/usr/bin/env bash

# Update script. Intended for developer use.

set -e

docker-compose run web yarn upgrade --latest
docker-compose run web bundle update
docker-compose down
docker-compose build
docker-compose run web ./build.sh
