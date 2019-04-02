#!/usr/bin/env bash

# Update script. Intended for developer use.

set -e

yarn upgrade --latest
bundle update

exec ./build.sh
