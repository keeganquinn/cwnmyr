# frozen_string_literal: true

set :application, 'cwnmyr'
set :repo_url, 'https://github.com/keeganquinn/cwnmyr.git'

set :rbenv_ruby, File.read('.ruby-version').strip

set :linked_dirs, fetch(:linked_dirs, []).push('node_modules')
set :linked_dirs, fetch(:linked_dirs, []).push('public/system')
set :linked_dirs, fetch(:linked_dirs, []).push('storage')

set :assets_dir, %w[storage]
set :local_assets_dir, %w[.]
set :skip_data_sync_confirm, true

namespace :db do
  desc 'Fetches remote database and stores it.'
  task :fetch do
    on roles(:db) do
      remote_db = Database::Remote.new(self)

      begin
        remote_db.dump.download('db/live.sql.gz')
      ensure
        remote_db.clean_dump_if_needed
      end
    end
  end
end

desc 'Create a database backup remote database data'
task backup: 'db:remote:backup'

namespace :web do
  desc 'Enable maintenance mode'
  task :lock do
    on primary :app do
      within release_path do
        execute :touch, 'tmp/maintenance.txt'
      end
    end
  end

  desc 'Disable maintenance mode'
  task :unlock do
    on primary :app do
      within release_path do
        execute :rm, '-f tmp/maintenance.txt'
      end
    end
  end
end

namespace :deploy do
  desc 'Symlink environment'
  task :symlink_env do
    on roles(:app) do
      target = "#{release_path}/.env.#{fetch(:rails_env)}"
      execute "rm -f #{target}"
      execute "ln -s /etc/rails/#{fetch(:application)}.env #{target}"
    end
  end
  task :restart do
    on roles(:app) do
      execute "kill -s SIGUSR1 $(cat #{shared_path}/puma.pid) || " \
              "sudo systemctl restart #{fetch(:application)}-web.target"
      execute "sudo systemctl restart #{fetch(:application)}-cinch.target"
    end
  end
end

after :'deploy:symlink:linked_dirs', :'deploy:symlink_env'

after :'deploy:publishing', :'foreman:export'
after :'deploy:publishing', :'deploy:restart'
