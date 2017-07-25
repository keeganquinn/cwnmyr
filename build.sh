#!/usr/bin/env bash

# Automated build script for cwnmyr. This script uses docker-compose to
# perform a complete self-contained run of all test suites and style checks.
# Intended for continuous integration use.

build=${BUILD_NUMBER:-"current"}
compose=(docker-compose "--project-name=cwnmyr")

set -ex

rm -rf checkstyle-*.xml coverage junit.xml rspec.xml log/* public/assets tmp/*

"${compose[@]}" down || true
"${compose[@]}" up -d

"${compose[@]}" exec web rake db:create db:schema:load RAILS_ENV=test

"${compose[@]}" exec web rake spec BUILD_NUMBER="${build}" || true

"${compose[@]}" exec web node_modules/.bin/jest || true

"${compose[@]}" exec web rubocop \
                --require rubocop/formatter/checkstyle_formatter \
                --format RuboCop::Formatter::CheckstyleFormatter \
                -o checkstyle-rubocop.xml || true

"${compose[@]}" exec web haml-lint app \
                --reporter checkstyle > checkstyle-haml-lint.xml || true

"${compose[@]}" exec web node_modules/.bin/eslint app \
                --format node_modules/eslint-formatter-checkstyle-* \
                > checkstyle-eslint.xml || true

"${compose[@]}" down
