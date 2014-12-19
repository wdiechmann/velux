#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

# ActiveRecord
require "./velux_app"
require "sinatra/activerecord/rake"


# Vlad requires us to prepare somewhat 
begin
  require 'vlad'
  Vlad.load( :app => nil, :scm => :git, :web => nil)
rescue
  # do nothing
end

#
#   rake set_site_release["20120125165204"]
desc "Convert all images"
task :convert_kidz do
  system 'cd public/images/brands && for d in jeff monday maybee rebus_boys rebus_girls; do find "$d" -name *.jpg|xargs rm -f; done'
  system 'cd public/images/brands && for d in jeff monday maybee rebus_boys rebus_girls; do find "$d" -name *.png|xargs rm -f; done'
  system "cnv_img"
end


set :application, "fbi"
set :repository, 'git@git4.alco.dk:laniel.git'
set :domain, "ruby4.alco.dk"
set :deploy_to, "/data2/html/sites/#{application}"
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

