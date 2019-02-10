# frozen_string_literal: true

require 'capybara/poltergeist'

Capybara.asset_host = 'http://localhost:3000'
Capybara.javascript_driver = :poltergeist
