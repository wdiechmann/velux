set :application, "fbi"
set :repository, 'git@git4.alco.dk:laniel.git'
set :domain, "ruby4.alco.dk"
set :deploy_to, "/data2/html/sites/#{application}"
set :revision, 'head'                                 # git branch to deploy


desc "Restart Passenger"
remote_task :restart_passenger, :roles => :app do
  run "touch #{current_path}/tmp/restart.txt"
end

desc "Load new customers"
remote_task :load_customers do
  Customer.import_csv_file "customers.csv"
end

desc "Update site"
task :update_site do
  require 'date'
  system "git add . && git ci -am 'updated on #{Date.today.to_s}'"
  system "git push"
  Rake.application.invoke_task("vlad:update")  
end
    
