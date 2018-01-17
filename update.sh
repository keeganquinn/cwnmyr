#!/usr/bin/env bash

# Update script for cwnmyr. Intended for developer use.

set -e

docker-compose run web yarn upgrade
docker-compose run web bundle update
docker-compose build
docker-compose run web rake