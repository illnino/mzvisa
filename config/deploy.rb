require "bundler/capistrano"
load "deploy/assets"

set :application, "mzvisa"
set :repository,  "git@github.com:illnino/mzvisa.git"

set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

server = "mzvisa.com"
role :web, server                          # Your HTTP server, Apache/etc
role :app, server                          # This may be the same as your `Web` server
role :db, server, :primary => true # This is where Rails migrations will run

set :user, "spree"

set :deploy_to, "/home/spree/#{application}"
set :use_sudo, false
set :deploy_via, :remote_cache
#set :ssh_options, {:forward_agent => true}

default_run_options[:pty] = true

default_run_options[:shell] = '/bin/bash --login'
default_environment["RAILS_ENV"] = 'production'

before "bundle:install" do
# 　　run "cd #{fetch(:latest_release)} && bundle config build.pg --with-pg=/usr/pgsql-9.2"
	run "cd #{fetch(:latest_release)} && bundle config build.pg --with-pg=/usr/pgsql-9.2"
end

namespace :deploy do
  %w[start stop restart].each do |command|
    desc "#{command} unicorn server"
    task command, roles: :app, except: {no_release: true} do
      run "/etc/init.d/unicorn_#{application} #{command}"
    end
  end

  task :create_spree_images_symlink, :roles => [:app] do
    run "rm -fr #{release_path}/public/spree"
    run "mkdir -p #{shared_path}/public/spree && ln -nfs #{shared_path}/public/spree #{release_path}/public/"
  end

  task :setup_config, roles: :app do
    sudo "ln -nfs #{current_path}/config/nginx.conf /etc/nginx/sites-enabled/#{application}"
    sudo "ln -nfs #{current_path}/config/unicorn_init.sh /etc/init.d/unicorn_#{application}"
    run "mkdir -p #{shared_path}/config"
    put File.read("config/database.example.yml"), "#{shared_path}/config/database.yml"
    puts "Now edit the config files in #{shared_path}."
  end
  after "deploy:setup", "deploy:setup_config"

  task :symlink_config, roles: :app do
    # run "rm #{release_path}/config/database.yml"
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end
  after "deploy:finalize_update", "deploy:symlink_config"

  desc "Make sure local git is in sync with remote."
  task :check_revision, roles: :web do
    unless `git rev-parse HEAD` == `git rev-parse origin/master`
      puts "WARNING: HEAD is not the same as origin/master"
      puts "Run `git push` to sync changes."
      exit
    end
  end
  before "deploy", "deploy:check_revision"
end

after "deploy:update", "deploy:create_spree_images_symlink"
after "deploy:restart", "deploy:cleanup" # leave the last 5 releases only