# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'rails'

gem 'foreman'
gem 'pg'
gem 'puma'

gem 'administrate'
gem 'bootsnap', require: false
gem 'devise'
gem 'dotenv-rails'
gem 'hamlit-rails'
gem 'jbuilder'
gem 'mini_magick'
gem 'omniauth'
gem 'pundit'
gem 'redcarpet'
gem 'turbolinks'
gem 'webpacker'

gem 'active_storage_validations'
gem 'acts-as-taggable-on'
gem 'administrate-field-active_storage'
gem 'ahoy_matey'
gem 'blazer'
gem 'cocoon'
gem 'elasticsearch'
gem 'geocoder'
gem 'netaddr'
gem 'notable'
gem 'paper_trail'
gem 'pg_query'
gem 'pghero'
gem 'rgl', require: 'rgl/adjacency'
gem 'rmagick'
gem 'searchkick'
gem 'simple_form'

group :development do
  gem 'better_errors'
  gem 'brakeman', require: false
  gem 'capistrano'
  gem 'capistrano-bundler'
  gem 'capistrano-db-tasks', require: false
  gem 'capistrano-foreman'
  gem 'capistrano-rails'
  gem 'capistrano-rbenv'
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
  gem 'unicorn'
  gem 'web-console'
end

group :development, :test do
  gem 'byebug', platform: :mri
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'rails-controller-testing'
  gem 'rspec-rails'
  gem 'rspec_junit_formatter'
  gem 'rubocop-checkstyle_formatter', require: false
  gem 'rubocop-performance'
  gem 'rubocop-rspec'
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
