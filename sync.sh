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
yarn install --frozen-lockfile


rm -f db/live.sql db/live.sql.gz

bundle exec cap production db:fetch
bundle exec cap production assets:pull

gunzip db/live.sql.gz

exec ./restore.sh
