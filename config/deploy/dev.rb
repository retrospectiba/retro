set :logs_path, "/abd/logs/retro"

role :app, "172.16.147.69"

after 'deploy', 'passenger:restart'
