# frozen_string_literal: true

set :stage, :staging
set :rails_env, 'production'

server 'scrap.quinn.tk', user: 'deploy', roles: %w[web app db], primary: true
set :deploy_to, '/srv/rails/cwnmyr'

set :foreman_use_sudo, :rbenv
set :foreman_init_system, 'systemd'
set :foreman_export_path, '/etc/systemd/system'
set :foreman_options,
    user: 'deploy',
    env: '.env.production',
    formation: 'all=1,release=0'
