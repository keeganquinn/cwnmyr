#!/usr/bin/env bash

# Database restore script. Intended for developer use.

set -e

bundle exec rake db:drop db:create
psql -h "${DB_HOST}" -U "${DB_USERNAME}" cwnmyr_dev -f db/live.sql
bundle exec rake db:environment:set
bundle exec rake db:migrate
