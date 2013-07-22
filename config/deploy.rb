# -*- encoding : utf-8 -*-
require 'capistrano/ext/multistage'
require 'bundler/capistrano'

def get_branch_name
  puts ''
  puts '*********************************************************************'
  puts "Type the reference to the branch, tag, or any SHA1 you are deploying."
  branch_name = Capistrano::CLI.ui.ask("Default: master")
  branch_name = 'master' if branch_name == ''
  branch_name
end

def get_stages
  Dir['deploy/*.rb'].collect {|file| File.basename(file).gsub(File.extname(file),'')}
end

def yes_no(message)
  Capistrano::CLI.ui.ask(%(#{message} [Type "yes" or "no" (default: "no")])) === "yes"
end

def _text(message)
  Capistrano::CLI.ui.ask(message)
end

def _pass(message)
  Capistrano::CLI.password_prompt(message)
end

set :application,       "retro"
set :deploy_to,         "/abd/app/#{application}"
set :user,              "danilol"
set :port,              5022
set :use_sudo,          false
set :keep_releases,     10
set :bundle_flags,      "--quiet"

# SCM Configurations
set :scm,               :git
set :repository,        "https://github.com/euricovidal/retro.git "
set :deploy_via,        :remote_cache
set :passenger_port,    30009

set :stages,            get_stages

before "deploy:update"         , "deploy:set_branch_name"
after "deploy:setup"           , "deploy:setup_config_shared"
after "deploy:finalize_update" , "deploy:relink_log"
after "deploy"                 , "deploy:cleanup"

namespace :passenger do
  desc "Start passenger server"
  task :start do
    run "cd #{current_path} && passenger start -e production -p #{passenger_port} -d"
  end

  desc "Stop passenger server"
  task :stop do
    run "cd #{current_path} && passenger stop -p #{passenger_port}"
  end

  desc "Restart passenger server"
  task :restart do
    run <<-CMD
      if [[ -f #{current_path}/tmp/pids/passenger.#{passenger_port}.pid ]];
      then
        cd #{current_path} && passenger stop -p #{passenger_port};
      fi
    CMD

    run "cd #{current_path} && passenger start -e production -p #{passenger_port} -d"
  end
end

namespace :deploy do
  desc "[internal] Relink log"
  task :relink_log do
    run <<-CMD
      mkdir #{logs_path};
      rm #{latest_release}/log &&
      ln -s #{logs_path} #{latest_release}/log
    CMD
  end

  desc "[internal] Set a branch/tag or SHA1"
  task :set_branch_name do
    set :branch, get_branch_name
  end

  desc "[internal] Create config dir on shared_path"
  task :setup_config_shared  do
    run <<-CMD
      mkdir -p #{shared_path}/config
    CMD
  end

  desc "Restarting passenger"
  task :restart, roles: :app, except: {no_release: true } do
    run <<-CMD
      mkdir -p #{current_path}/tmp &&
      touch #{current_path}/tmp/restart.txt
    CMD
  end

  [:stop, :start].each do |t|
    desc "[internal] #{t} server"
    task t, role: :app, except: {no_release: true } do
      puts "Do nothing for #{t} cap task."
    end
  end
end

namespace :rake do
  desc "Run a task on a remote server."
  # run like: cap qa rake:invoke task=a_certain_task
  task :invoke do
    run("cd #{deploy_to}/current; /usr/bin/env rake #{ENV['task']}")
  end
end
