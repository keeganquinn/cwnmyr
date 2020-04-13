#!/usr/bin/env bash

# Deployment script for cwnmyr. Intended for operations use.

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
npm install --frozen-lockfile

bundle exec cap staging deploy

echo
echo "Verify staging site now: https://cwnmyr-staging.quinn.tk/"
echo "RET to go live, C-c to cancel."
read -r

bundle exec cap production deploy

echo
echo "Deployed live site: https://nodes.personaltelco.net/"

exit 0
