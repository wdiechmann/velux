# encoding: UTF-8
require 'rubygems'
require 'bundler'

Bundler.require

root_dir = File.dirname(__FILE__)
set :environment, ENV['RACK_ENV'].to_sym
set :root, root_dir
set :app_file, File.join(root_dir, 'app.rb')
APP_ROOT = root_dir
require './velux_app'

run VeluxApp
