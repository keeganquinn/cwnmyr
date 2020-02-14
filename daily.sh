#!/usr/bin/env bash

# Run cwnmyr seed task.

export PATH="$HOME/.rbenv/bin:$PATH"
export RAILS_ENV=${RAILS_ENV:-"production"}
export RUBYOPT=-W0
eval "$(rbenv init -)"

set -e

cwnmyr="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd "${cwnmyr}"

bundle exec rake db:seed
