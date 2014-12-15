# encoding: UTF-8
#/* - - - - - - - - - - - - - - - - - - - - -
#
#   Title : WEB Appliances Crest Inc, Web Form Framework
#   Author : Enrique Phillips 
#   URL : http://www.wac.bz
#
#- - - - - - - - - - - - - - - - - - - - - */
require 'sinatra/base'
require 'sinatra/head'
require 'sinatra/namespace'
require "sinatra/activerecord"

require_relative "models/customer"

class LanielApp < Sinatra::Base

  register Sinatra::ActiveRecordExtension
  register Sinatra::Head
  register Sinatra::Namespace
  use Rack::Logger

  set :app_file, __FILE__
  set :root, File.dirname(__FILE__)                                         # where is ROOT (and /public)
  set :static, true                                                         # serve static file if any
  set :public_folder, Proc.new { File.join(root, "public") }                # -     and from where
  set :views, Proc.new { File.join(root, "templates") }

  # set :database, 'mysql2://root:Iwbb!@10.0.0.119:3306/laniel_production'

  # only when hit from 
  # "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_5) AppleWebKit/537.11 (KHTML, like Gecko) Chrome/23.0.1271.64 Safari/537.11"
  # get '/', :agent => / Firefox\/(.*)$/ do
  #   "You're using Firefox version #{params[:agent]}"
  # end

  
  before :agent => /^(.*)$/ do
    
    client = []
    params[:agent][0].split(" ").collect do |browser|
      client << "phone" if (browser =~ /[M|m]obile/)        # 320*480
      client << "phone" if (browser =~ /iPhone/)
      client << "small" if (browser =~ /iPad/)              # 768*1024
      client << "large" if (browser =~ /Mac/ )              # -
      client << "large" if (browser =~ /Chrome/ )           # -
      client << "large" if (browser =~ /Windows/ )
      client << "large" if (browser =~ /Firefox/ )
    end
    @img_res = client.uniq.compact.first
    @img_res ||= 'hi_res'
    @client = params[:agent][0]

    title << "Fashion Brands Inc"
    stylesheets << "bootstrap.min.css"
    stylesheets << "bootstrap-responsive.min.css"
    stylesheets << "style.css"
    javascripts << 'bootstrap.min.js'
    javascripts << 'jquery.mobile.custom.min.js'
    
  end  
  
  helpers do
    
    def logger
      request.logger
    end
          
    def get_background(brand)
      files = Dir.entries( File.join(settings.public_folder, "images", "brands", brand, "backgrounds", @img_res)) rescue []
      files.any? && files.delete(".") && files.delete("..") && files.delete(".DS_Store") #if files.any?
      nr = 0 + rand(files.count)
      nr -= 1 if files.count == nr
      logger.info "found %s files - chose %s" % [files.count,nr]
      "/images/brands/#{brand}/backgrounds/#{@img_res}/#{files[nr]}" rescue ""
    end
    
    def get_width
      case @img_res
      when 'phone'; "480px"
      when 'small'; "768px"
      when 'large'; "768px"
      when 'huge'; "1220px"
      end
    end
  end  
  
  get '/download/*' do |fil|
    haml :download, locals: { image: '/'+fil.gsub(/\.png/,".jpg") }
  end
  
  get "/map/*" do |brand|
    haml :map, locals: { brand: brand }
  end
  
end

require_relative 'iddenim'
require_relative 'superego'
require_relative 'fbi'
require_relative 'jeff'
require_relative 'maybee'
require_relative 'monday'
require_relative 'rebus_boys'
require_relative 'rebus_girls'
        
##########################################################
# works not!
##########################################################
# 
# get '/', :agent => /Songbird (\d\.\d)[\d\/]*?/ do
#   "You're using Songbird version #{params[:agent][0]}"
# end

# not_found do
#   "fejl!"
# end    

# not in development at least - perhaps because Sinatra does strange stuff with error method in development
#
# error MyCustomError do
#   'So what happened was...' + env['sinatra.error'].message
# end
# 
# error 400..510 do
#   'Boom'
# end
# 
# get '/' do
#   raise MyCustomError, '10'
# end


##########################################################
# works
##########################################################


# 
# get '/' do
#   attachment "info.txt"
#   "store it!"
# end

# template :layout do
#   "%html\n  %body{style: 'background-color: #111'}\n    =yield\n"
# end
# 
# template :index do
#   '%div.title{ style: "background-color: #989afd"} Hello World!'
# end
# 
# get '/' do
#   haml :index, :layout => !request.xhr?
# end


# get '/:id' do
#   @foo = Employee.find(params[:id])
#   haml '%h1= @foo.name'
# end

# get '/' do
#   haml '%div.title Hello World'
# end
# 

# get '/' do
#   code = "<%= Time.now %>"
#   erb code
# end


# class Stream
#   def each
#     10000.times { |i| yield "#{i}\n" }
#   end
# end
# 
# get('/') { Stream.new }    
    
