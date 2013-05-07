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

default_run_options[:shell] = '/bin/bash --login'
default_environment["RAILS_ENV"] = 'production'

before "bundle:install" do
# 　　run "cd #{fetch(:latest_release)} && bundle config build.pg --with-pg=/usr/pgsql-9.2"
	run "cd #{fetch(:latest_release)} && bundle config build.pg --with-pg=/usr/pgsql-9.2"
end

task :symlink_database_yml do
  run "rm #{release_path}/config/database.yml"
  run "ln -sfn #{shared_path}/config/database.yml
       #{release_path}/config/database.yml"
end
after "bundle:install", "symlink_database_yml"


namespace :unicorn do
  desc "Zero-downtime restart of Unicorn"
  task :restart, except: { no_release: true } do
    run "kill -s USR2 `cat #{shared_path}/tmp/pids/unicorn.mzvisa.pid`"
  end

  desc "Start unicorn"
  task :start, except: { no_release: true } do
    run "cd #{current_path} ; bundle exec unicorn_rails -c config/unicorn.rb -D"
  end

  desc "Stop unicorn"
  task :stop, except: { no_release: true } do
    run "kill -s QUIT `cat #{shared_path}/tmp/pids/unicorn.mzvisa.pid`"
  end
end

after "deploy:restart", "unicorn:restart"


# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end