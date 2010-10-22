require 'mongrel_cluster/recipes'


set :application, "cwnmyr"
set :repository,  "svn+ssh://beast.sniz.net/srv/svn/sniz/code/trunk/cwnmyr"

set :synchronous_connect, true
set :use_sudo, false
set :deploy_via, :copy
set :copy_strategy, :export

set :user, "rails"
set :deploy_to, "/srv/rails/#{application}"
set :shared_dir, "shared"

set :mongrel_conf, "#{current_path}/config/mongrel_cluster.yml"


role :app, "donk.personaltelco.net"
role :web, "donk.personaltelco.net"
role :db,  "donk.personaltelco.net", :primary => true


desc "Create database.yml in shared/config" 
task :after_setup do
  database_configuration = <<-EOF
development:
  adapter: sqlite3
  database: db/development.sqlite3
  timeout: 5000

test:
  adapter: sqlite3
  database: ':memory:' 
  verbosity: silent
  timeout: 5000

production:
  adapter: postgresql
  host: ip6-localhost
  database: cwnmyr
  username: USER_HERE
  password: PASSWORD_HERE
EOF

  run "mkdir -p #{deploy_to}/#{shared_dir}/config" 
  put database_configuration, "#{deploy_to}/#{shared_dir}/config/database.yml" 
end

desc "Hook task run after update_code" 
task :after_update_code do
  run "ln -nfs #{deploy_to}/#{shared_dir}/config/database.yml #{release_path}/config/database.yml" 
  run "ln -nfs #{deploy_to}/#{shared_dir}/config/gmaps_api_key.yml #{release_path}/config/gmaps_api_key.yml"
end

