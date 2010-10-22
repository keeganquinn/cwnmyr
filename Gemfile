source 'http://rubygems.org'

gem 'rails', '3.0.1'

gem 'capistrano'
gem 'devise'
gem 'haml'
gem 'netaddr', :require => 'cidr'
gem 'rgl', :require => 'rgl/adjacency'
gem 'rmagick', :require => 'RMagick'
gem 'will_paginate'

group :development, :test do
  gem 'autotest-rails'
  gem 'cucumber-rails'
  gem 'railroad'
  gem 'rspec-rails'
  gem 'sqlite3-ruby', :require => 'sqlite3'
  gem 'webrat'
end

group :production do
  # Eventually, we'll be using Pg in production
  #gem 'pg'
  gem 'sqlite3-ruby', :require => 'sqlite3'
end
