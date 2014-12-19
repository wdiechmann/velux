set :application, "velux"
set :repository, 'git@github.com:wdiechmann/velux.git'
set :domain, "ruby5.alco.dk"
set :deploy_to, "/var/www/#{fetch(application)}"
set :revision, 'head'                                 # git branch to deploy


desc "Restart Passenger"
remote_task :restart_passenger, :roles => :app do
  run "touch #{current_path}/tmp/restart.txt"
end

desc "Update site"
task :update_site do
  require 'date'
  system "git add . && git ci -am 'updated on #{Date.today.to_s}'"
  system "git push"
  Rake.application.invoke_task("vlad:update")
end
