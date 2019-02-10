# frozen_string_literal: true

# Load DSL and Setup Up Stages
require 'capistrano/setup'

# Includes default deployment tasks
require 'capistrano/deploy'

# Git SCM plugin
require 'capistrano/scm/git'
install_plugin Capistrano::SCM::Git

# Includes tasks from other gems
require 'capistrano/bundler'
require 'capistrano/foreman'
require 'capistrano/rails'
require 'capistrano/rbenv'

# Loads custom tasks from `lib/capistrano/tasks' if you have any defined.
Dir.glob('lib/capistrano/tasks/*.cap').each { |r| import r }
