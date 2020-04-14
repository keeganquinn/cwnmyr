# frozen_string_literal: true

ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../Gemfile', __dir__)
ENV['WEBPACKER_NODE_MODULES_BIN_PATH'] ||= 'node_modules/.bin'

require 'bundler/setup' # Set up gems listed in the Gemfile.
require 'bootsnap/setup'
