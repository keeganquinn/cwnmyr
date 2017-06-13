set :application, 'cwnmyr'
set :repo_url, 'https://github.com/keeganquinn/cwnmyr.git'

set :rbenv_ruby, File.read('.ruby-version').strip


# Quick and dirty rbenv-sudo support. Contrib to capistrano-rbenv gem?
set :rbenv_sudo_bins, ['foreman']

rbenv_sudo_prefix = fetch(:rbenv_sudo_prefix, proc { "#{fetch(:rbenv_path)}/bin/rbenv sudo" })

fetch(:rbenv_sudo_bins).each do |command|
  SSHKit.config.command_map.prefix[command.to_sym].unshift(rbenv_sudo_prefix)
end

namespace :deploy do

  desc "Symlink environment"
  task :symlink_env do
    on roles(:app) do
      execute "rm -f #{release_path}/.env.production"
      execute "ln -s /etc/rails/cwnmyr.env #{release_path}/.env.production"
    end
  end

end

namespace :foreman do

  desc "Fix permissions"
  task :fix_perms do
    on roles(:app) do
      execute "sudo chmod o-r /etc/systemd/system/cwnmyr*.service"
    end
  end

end

after :'deploy:symlink:linked_dirs', :'deploy:symlink_env'
after :'foreman:export', :'foreman:fix_perms'

after :'deploy:publishing', :'foreman:export'
after :'deploy:publishing', :'foreman:daemon_reload'
after :'deploy:publishing', :'foreman:restart'
