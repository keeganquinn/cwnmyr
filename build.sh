#!/usr/bin/env bash

# Automated build script. Intended for continuous integration use.

build=${BUILD_NUMBER:-"current"}

set -ex

find . -maxdepth 2 -name '*.sh' -print0 | xargs -0 -n1 -t shellcheck


[ -d .bundle ] || mkdir -p .bundle
[ -f .bundle/config ] || (
    echo '---'
    echo 'BUNDLE_PATH: "vendor"'
    echo 'BUNDLE_DISABLE_SHARED_GEMS: "true"'
    echo 'BUNDLE_WITHOUT: "production"'
) > .bundle/config
bundle install
yarn install --frozen-lockfile


rm -rf checkstyle-*.xml coverage coverage-js doc jsdoc junit.xml rspec.xml \
   log/* public/assets tmp/*

yarn -s test || true
yarn -s jsdoc || true
yarn -s jsonlint || true
yarn -s pkglint || true

yarn -s lint --format node_modules/eslint-formatter-checkstyle-* \
     > checkstyle-eslint.xml || true

bundle exec rubocop --require rubocop/formatter/checkstyle_formatter \
       --format RuboCop::Formatter::CheckstyleFormatter \
       -o checkstyle-rubocop.xml || true

bundle exec haml-lint app --reporter checkstyle \
       > checkstyle-haml-lint.xml || true

bundle exec yard || true

bundle exec rake db:create db:environment:set db:schema:load RAILS_ENV=test

bundle exec rake spec BUILD_NUMBER="${build}" || true

exit 0
