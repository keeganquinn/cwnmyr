# frozen_string_literal: true

require 'capistrano-db-tasks'

set :application, 'cwnmyr'
set :repo_url, 'https://github.com/keeganquinn/cwnmyr.git'

set :rbenv_ruby, File.read('.ruby-version').strip

set :linked_dirs, fetch(:linked_dirs, []).push('node_modules')
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

namespace :deploy do
  desc 'Symlink environment'
  task :symlink_env do
    on roles(:app) do
      execute "rm -f #{release_path}/.env.production"
      execute "ln -s /etc/rails/cwnmyr.env #{release_path}/.env.production"
    end
  end
end

after :'deploy:symlink:linked_dirs', :'deploy:symlink_env'

after :'deploy:publishing', :'foreman:export'
after :'deploy:publishing', :'foreman:restart'
