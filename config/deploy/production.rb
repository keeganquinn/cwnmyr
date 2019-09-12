# frozen_string_literal: true

set :stage, :production

server 'turn.personaltelco.net',
       user: 'deploy', roles: %w[web app db], primary: true
set :deploy_to, '/srv/rails/cwnmyr'

set :foreman_use_sudo, true
set :foreman_init_system, 'systemd'
set :foreman_export_path, '/etc/systemd/system'
set :foreman_options,
    user: 'deploy',
    env: '.env.production',
    formation: 'all=1,release=0'
