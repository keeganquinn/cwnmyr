#!/usr/bin/env bash

# Deployment script for cwnmyr. Intended for operations use.

set -e

bundle install
bundle exec cap staging deploy

echo "Verify staging site now. Return to go live, ctrl-c to cancel."
read -r

bundle exec cap production deploy
bundle exec cap personaltelco deploy
