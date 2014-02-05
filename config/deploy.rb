set :application, 'retro'
set :repo_url,'git@bitbucket.org:abrilmdia/iba-retrospectiba.git'
set :deploy_to, '/home/ec2-user/app/retro'

# RVM confs
set :rvm_ruby_string, 'ruby-1.9.3-p484@retro'
set :rvm_type, :user

# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

# set :scm, :git

# set :format, :pretty
# set :log_level, :debug
# set :pty, true

set :linked_files, %w{config/database.yml}
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# set :default_env, { path: "/opt/ruby/bin:$PATH" }
set :keep_releases, 5

namespace :deploy do
  before 'deploy:updated', :bundle do
    on roles(:app), in: :sequence, wait: 5 do
      within release_path do
        execute :bundle, 'install --quiet --without development test'
      end
    end
  end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :finishing, 'deploy:cleanup'
end
