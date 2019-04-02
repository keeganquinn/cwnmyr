#!/usr/bin/env bash

# Automated build script for cwnmyr. Intended for continuous integration use.

build=${BUILD_NUMBER:-"current"}

export CC_TEST_REPORTER_ID=32acafd5a9567429a9c6a9c05745fce5e139ce8eb412e6a5e424461f070f0dfa
cc_test_reporter=https://codeclimate.com/downloads/test-reporter/test-reporter-latest-linux-amd64

set -ex

[ -d .bundle ] || mkdir -p .bundle
[ -f .bundle/config ] || (
    echo '---'
    echo 'BUNDLE_PATH: "vendor"'
    echo 'BUNDLE_DISABLE_SHARED_GEMS: "true"'
    echo 'BUNDLE_WITHOUT: "production"'
) > .bundle/config
bundle install
yarn install


rm -rf checkstyle-*.xml coverage coverage-js junit.xml rspec.xml \
   log/* public/assets tmp/*

[ "${build}" != "current" ] && {
    curl -L "${cc_test_reporter}" > ./cc-test-reporter
    chmod +x ./cc-test-reporter
    ./cc-test-reporter before-build
    report() {
        rc=$?
        ./cc-test-reporter after-build --exit-code $rc
        exit $rc
    }
    trap report INT TERM
}

yarn -s test || true

yarn -s lint --format node_modules/eslint-formatter-checkstyle-* \
     > checkstyle-eslint.xml || true

bundle exec rubocop --require rubocop/formatter/checkstyle_formatter \
       --format RuboCop::Formatter::CheckstyleFormatter \
       -o checkstyle-rubocop.xml || true

bundle exec haml-lint app --reporter checkstyle \
       > checkstyle-haml-lint.xml || true

bundle exec rake db:create db:environment:set db:schema:load RAILS_ENV=test

bundle exec rake spec BUILD_NUMBER="${build}" || true

[ "${build}" != "current" ] && {
    ./cc-test-reporter after-build --exit-code 0
}

exit 0
