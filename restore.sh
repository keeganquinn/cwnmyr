#!/usr/bin/env bash

# Database restore script. Intended for developer use.

set -e

rake db:drop db:create
psql -h "${DB_HOST}" -U "${DB_USERNAME}" cwnmyr_dev -f db/live.sql
rake db:environment:set
rake db:migrate
