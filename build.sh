#!/usr/bin/env bash

# Automated build script for cwnmyr. This script uses docker-compose to
# perform a complete self-contained run of all test suites and style checks.
# Intended for continuous integration use.

build=${BUILD_NUMBER:-"current"}
compose=(docker-compose -p cwnmyr)
exec=("${compose[@]}" exec -T web)

set -ex

rm -rf checkstyle-*.xml coverage junit.xml rspec.xml log/* public/assets tmp/*

"${compose[@]}" down || true
"${compose[@]}" up -d

"${exec[@]}" rake db:create db:schema:load RAILS_ENV=test

"${exec[@]}" rake spec BUILD_NUMBER="${build}" || true

"${exec[@]}" node_modules/.bin/jest || true

"${exec[@]}" rubocop \
             --require rubocop/formatter/checkstyle_formatter \
             --format RuboCop::Formatter::CheckstyleFormatter \
             -o checkstyle-rubocop.xml || true

"${exec[@]}" haml-lint app \
             --reporter checkstyle > checkstyle-haml-lint.xml || true

"${exec[@]}" node_modules/.bin/eslint app \
             --format node_modules/eslint-formatter-checkstyle-* \
             > checkstyle-eslint.xml || true

"${compose[@]}" down
