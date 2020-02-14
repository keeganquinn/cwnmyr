#!/usr/bin/env bash

# Run cwnmyr seed task.

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

set -e

(cd /srv/rails/cwnmyr/current; RAILS_ENV=production bundle exec rake db:seed)
