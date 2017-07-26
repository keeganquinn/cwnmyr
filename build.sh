#!/usr/bin/env bash

# Automated build script for cwnmyr. Intended for continuous integration use.

build=${BUILD_NUMBER:-"current"}

set -ex

rm -rf checkstyle-*.xml coverage junit.xml rspec.xml log/* public/assets tmp/*

bundle exec rake db:create db:environment:set db:schema:load RAILS_ENV=test

bundle exec rake spec BUILD_NUMBER="${build}" || true

node_modules/.bin/jest || true

bundle exec rubocop --require rubocop/formatter/checkstyle_formatter \
       --format RuboCop::Formatter::CheckstyleFormatter \
       -o checkstyle-rubocop.xml || true

bundle exec haml-lint app \
       --reporter checkstyle > checkstyle-haml-lint.xml || true

node_modules/.bin/eslint \
    app --format node_modules/eslint-formatter-checkstyle-* \
    > checkstyle-eslint.xml || true
