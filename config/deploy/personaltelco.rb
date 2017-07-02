set :stage, :production

server 'drei.personaltelco.net', user: 'deploy', roles: %w{web app db}, primary: true
set :deploy_to, '/srv/rails/cwnmyr'

set :foreman_export_format, 'systemd'
set :foreman_export_path, '/etc/systemd/system'
set :foreman_user, 'deploy'
set :foreman_flags, '-e /etc/rails/cwnmyr.env'
