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

set :keep_releases, 5
set :application, "retro"
set :repository, " git@bitbucket.org:abrilmdia/iba-retrospectiba.git"
set :use_sudo, false
set :port, 5022
set :deploy_branch, ENV['BRANCH'] if ENV['BRANCH']
set :bundle_flags, "--quiet"
set :user, "dls"
set :deploy_to,     "/abd/app/#{application}"
set :logs_path,     "/data_logs/#{application}/$HOSTNAME"
set :image_path,    "/abd/app/#{application}/images"

before "deploy:update", "deploy:set_branch_name"

# SCM Configurations
set :scm, :git
set :stack, :passenger

namespace :deploy do
  desc 'Restart passenger process'
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end

  desc "[internal] Set a branch/tag or SHA1"
  task :set_branch_name do
    set :branch, get_branch_name
  end

  desc "[internal] Relink log"
  task :relink_log do
     run <<-CMD
        mkdir #{logs_path};
        rm #{latest_release}/log &&
        ln -s #{logs_path} #{latest_release}/log &&
        ln -s #{image_path} #{latest_release}/public/images
     CMD
  end
end

namespace :rake do
  desc "Run a task on a remote server."
  # run like: cap qa rake:invoke task=a_certain_task
  task :invoke do
   run("cd #{deploy_to}/current; /usr/bin/env rake #{ENV['task']}")
  end
end

after "deploy:finalize_update", "deploy:relink_log"
after "deploy:update", "deploy:cleanup"
