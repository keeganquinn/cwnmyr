#!/usr/bin/env bash

# Deployment script for cwnmyr. Intended for operations use.

set -e

[ -d .bundle ] || mkdir -p .bundle
[ -f .bundle/config ] || (
    echo '---'
    echo 'BUNDLE_PATH: "vendor"'
    echo 'BUNDLE_DISABLE_SHARED_GEMS: "true"'
    echo 'BUNDLE_WITHOUT: "production"'
) > .bundle/config


bundle install
bundle exec cap staging deploy

echo "Verify staging site now. Return to go live, ctrl-c to cancel."
read -r

bundle exec cap production deploy
bundle exec cap personaltelco deploy
