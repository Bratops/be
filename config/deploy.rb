# config valid only for Capistrano 3.1
lock "3.2.1"

set :application, "brasbe"
set :deployer, "nsn"
set :repo_url, "git@github.com:Bratops/be.git"

# rbenv
set :rbenv_type, :user
set :rbenv_ruby, "2.1.2"
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

# Default deploy_to directory is /var/www/my_app
# set :deploy_to, '/var/www/my_app'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
set :log_level, :info

# Default value for :pty is false
set :pty, true

# Default value for :linked_files is []
set :linked_files, %w{config/database.yml config/application.yml config/hipchat.yml}

# Default value for linked_dirs is []
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 20

# Required
set :hipchat_token, "UxADLEuL94bXRHEq4ZyLnM4W4PeE4HWia17cAOjO"
set :hipchat_from, "speedoflight"
set :hipchat_room_name, "brasbe" # If you pass an array such as ["room_a", "room_b"] you can send announcements to multiple rooms.
# Optional
set :hipchat_announce, true # notify users
set :hipchat_color, "gray" #normal message color
set :hipchat_success_color, "green" #finished deployment message color
set :hipchat_failed_color, "red" #cancelled deployment message color
set :hipchat_message_format, "html" # Sets the deployment message format, see https://www.hipchat.com/docs/api/method/rooms/message
set :hipchat_options, {
  api_version: "v2" # Set "v2" to send messages with API v2
}

# cap3 db dump
require 'capistrano-db-tasks'
# if you want to remove the local dump file after loading
#set :db_local_clean, true
# if you want to remove the dump file from the server after downloading
#set :db_remote_clean, true
# If you want to import assets, you can change default asset dir (default = system)
# This directory must be in your shared directory on the server
set :assets_dir, %w(public/assets)
set :local_assets_dir, %w(public/assets)
# if you want to work on a specific local environment (default = ENV['RAILS_ENV'] || 'development')
#set :locals_rails_env, "production"

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end
