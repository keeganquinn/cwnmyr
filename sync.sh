#!/usr/bin/env bash

# Sync script. Intended for developer use.

set -e

ssh-add -l >/dev/null || ssh-add

[ -d .bundle ] || mkdir -p .bundle
[ -f .bundle/config ] || (
    echo '---'
    echo 'BUNDLE_PATH: "vendor"'
    echo 'BUNDLE_DISABLE_SHARED_GEMS: "true"'
    echo 'BUNDLE_WITHOUT: "production"'
) > .bundle/config


bundle install
bundle exec cap production db:fetch

gunzip db/live.sql.gz

docker-compose run web ./restore.sh
