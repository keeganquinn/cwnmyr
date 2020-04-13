#!/usr/bin/env bash

# Update script. Intended for developer use.

set -e

npm update
bundle update

exec ./build.sh
