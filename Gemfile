# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'rails'

gem 'pg'
gem 'puma'

gem 'administrate'
gem 'bootsnap', require: false
gem 'devise'
gem 'dotenv-rails'
gem 'hamlit-rails'
gem 'image_processing'
gem 'jbuilder'
gem 'omniauth-facebook'
gem 'omniauth-google-oauth2'
gem 'pundit'
gem 'redcarpet'
gem 'simple_form'
gem 'turbolinks'
gem 'turbolinks-form'
gem 'webpacker'

gem 'active_storage_validations'
gem 'administrate-field-active_storage'
gem 'ahoy_email'
gem 'ahoy_matey'
gem 'blazer'
gem 'client_side_validations'
gem 'client_side_validations-simple_form'
gem 'cocoon'
gem 'geocoder'
gem 'jenkins_api_client'
gem 'mailkick'
gem 'netaddr'
gem 'notable'
gem 'paper_trail'
gem 'pg_query'
gem 'pghero'
gem 'premailer-rails'
gem 'rgl', require: 'rgl/adjacency'
gem 'rmagick'

group :development do
  gem 'better_errors'
  gem 'brakeman', require: false
  gem 'capistrano', require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano-db-tasks', require: false
  gem 'capistrano-foreman', require: false
  gem 'capistrano-rails', require: false
  gem 'capistrano-rbenv', require: false
  gem 'guard-rspec', require: false
  gem 'haml_lint', require: false
  gem 'html2haml', require: false
  gem 'listen'
  gem 'rails_layout'
  gem 'rb-fchange', require: false
  gem 'rb-fsevent', require: false
  gem 'rb-inotify', require: false
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'spring-watcher-listen'
  gem 'web-console'
end

group :development, :test do
  gem 'byebug', platform: :mri
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'rails-controller-testing'
  gem 'rspec-rails'
  gem 'rspec_junit_formatter', require: false
  gem 'rubocop-checkstyle_formatter', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rspec', require: false
end

group :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'launchy'
  gem 'poltergeist'
  gem 'shoulda-matchers'
  gem 'simplecov', require: false
  gem 'simplecov-rcov', require: false
end
