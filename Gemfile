source 'https://rubygems.org'
git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end
ruby '2.3.3'
gem 'rails', '~> 5.0.1'
gem 'pg'
#gem 'redis'
gem 'puma', '~> 3.0'
gem 'dotenv-rails'
gem 'foreman'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'jquery-rails'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
group :development, :test do
  gem 'byebug', platform: :mri
end
group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem 'administrate'
gem 'bootstrap-sass'
gem 'bourbon'
gem 'devise'
gem 'haml-rails'
gem 'high_voltage'
gem 'pundit'
gem 'redcarpet'
gem 'simple_form'
gem 'omniauth'
group :development do
  gem 'better_errors'
  gem 'capistrano'
  gem 'capistrano-bundler'
  gem 'capistrano-foreman', github: 'koenpunt/capistrano-foreman', branch: 'systemd'
  gem 'capistrano-rails', '~> 1.1.0'
  gem 'capistrano-rails-console'
  gem 'capistrano-rbenv'
  gem 'capistrano3-puma'
  gem 'guard-bundler'
  gem 'guard-rails'
  gem 'guard-rspec'
  gem 'html2haml'
  gem 'rails_layout'
  gem 'rb-fchange', require: false
  gem 'rb-fsevent', require: false
  gem 'rb-inotify', require: false
  gem 'spring-commands-rspec'
end
group :development, :test do
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'rspec-rails'
  gem 'rspec_junit_formatter'
end
group :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'launchy'
  gem 'poltergeist'
  gem 'shoulda-matchers', git: 'https://github.com/thoughtbot/shoulda-matchers.git', branch: 'rails-5'
  gem 'simplecov', require: false
  gem 'simplecov-rcov', require: false
end

gem 'underscore-rails'
gem 'geocoder'
gem 'gmaps4rails'
gem 'netaddr', require: 'cidr'
gem 'rgl', require: 'rgl/adjacency'
gem 'rmagick'
