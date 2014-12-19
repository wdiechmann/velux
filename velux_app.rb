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
require 'sinatra/static_assets'
require "sinatra/activerecord"
require 'carrierwave'
require 'carrierwave/orm/activerecord'
require 'json'

require 'sinatra/flash'

class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  process :resize_to_fit => [400, 300]

  version :thumb do
    process :resize_to_fill => [100,75]
  end

  storage :file

  def store_dir
    'public/images/uploads'
  end  
  
  
end

require_relative "models/project"
require_relative "models/project_screen"
require_relative "models/login_screen"
require_relative "models/user"

require_relative 'lib/raw_upload'

class Uploader < Sinatra::Base

  use Rack::RawUpload

  configure do
    set :root, File.dirname(__FILE__) 
    set :uploads, File.join(root, 'public/images', 'uploads')
    Dir.mkdir uploads unless Dir.exists? uploads
  end
  
  get '/uploads/:filename' do |filename|
  end
    

  post '/upload' do
    content_type 'application/json', :charset => 'utf-8' if request.xhr?
    file_hash = params[:file]
    save_path = File.join settings.uploads, file_hash[:filename]
    File.open(save_path, 'wb') { |f| f.write file_hash[:tempfile].read }
    
    # should allways return json
    file_hash.to_json
  end

end

class VeluxApp < Sinatra::Base

  enable :sessions

  set :root, File.dirname(__FILE__)                                         # where is ROOT (and /public)
  set :views, Proc.new { File.join(root, "templates") }
  set :app_file, __FILE__
  set :static, true                                                         # serve static file if any
  set :public_folder, Proc.new { File.join(root, "public") }                # -     and from where
  set :uploads, File.join(root, 'public/images', 'uploads')


  # middleware will run before filters
  use LoginScreen
  use ProjectScreen
  use Uploader

  register Sinatra::ActiveRecordExtension
  register Sinatra::Head
  register Sinatra::Namespace
  register Sinatra::Flash

  Dir.mkdir uploads unless Dir.exists? uploads

  before do
    title << "Velux"
    stylesheets << "bootstrap.min.css"
    stylesheets << "bootstrap-responsive.min.css"
    stylesheets << "style.css"
    javascripts << 'bootstrap.min.js'
    javascripts << 'jquery.livequery.js'
    javascripts << 'jquery.xhr-upload.js'
    javascripts << 'jquery.mobile.custom.min.js'

    # if request.path_info =~ /project/ && session['user_name'].nil?
    #   redirect '/login'
    # end
  end

  get '/' do
    haml :map, format: :html5
  end
    

  # get('/') { "Hello #{session['user_name']}." }
  
end


# require 'sinatra/base'
# require 'sinatra/head'
# require 'sinatra/namespace'
# require "sinatra/activerecord"
# require 'carrierwave'
# require 'sinatra/flash'
#
# class ImageUploader < CarrierWave::Uploader::Base
#   storage :file
# end
#
# require_relative "models/project"
# require_relative "models/user"
#
# class VeluxApp < Sinatra::Base
#
#   enable :sessions
#
#   register Sinatra::ActiveRecordExtension
#   register Sinatra::Head
#   register Sinatra::Namespace
#   register Sinatra::Flash
#
#   use Rack::Logger
#
#   set :app_file, __FILE__
#   set :root, File.dirname(__FILE__)                                         # where is ROOT (and /public)
#   set :static, true                                                         # serve static file if any
#   set :public_folder, Proc.new { File.join(root, "public") }                # -     and from where
#   set :views, Proc.new { File.join(root, "templates") }
#
#   # set :database, 'mysql2://root:Iwbb!@10.0.0.119:3306/laniel_production'
#
#   # only when hit from
#   # "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_5) AppleWebKit/537.11 (KHTML, like Gecko) Chrome/23.0.1271.64 Safari/537.11"
#   # get '/', :agent => / Firefox\/(.*)$/ do
#   #   "You're using Firefox version #{params[:agent]}"
#   # end
#
#
#   before :agent => /^(.*)$/ do
#
#     client = []
#     params[:agent][0].split(" ").collect do |browser|
#       client << "phone" if (browser =~ /[M|m]obile/)        # 320*480
#       client << "phone" if (browser =~ /iPhone/)
#       client << "small" if (browser =~ /iPad/)              # 768*1024
#       client << "large" if (browser =~ /Mac/ )              # -
#       client << "large" if (browser =~ /Chrome/ )           # -
#       client << "large" if (browser =~ /Windows/ )
#       client << "large" if (browser =~ /Firefox/ )
#     end
#     @img_res = client.uniq.compact.first
#     @img_res ||= 'hi_res'
#     @client = params[:agent][0]
#
#     title << "Velux"
#     stylesheets << "bootstrap.min.css"
#     stylesheets << "bootstrap-responsive.min.css"
#     stylesheets << "style.css"
#     javascripts << 'bootstrap.min.js'
#     javascripts << 'jquery.mobile.custom.min.js'
#
#   end
#
#   register do
#     def auth (type)
#       condition do
#         redirect "/login" unless send("is_#{type}?")
#       end
#     end
#   end
#
#   before do
#     @user = session[:user_id].nil? ? nil : User.find(session[:user_id])
#   end
#
#   get "/projects/new", :auth => :user do
#     haml :project_new
#   end
#
#   get "/signup" do
#     @user ||= User.new
#     puts flash
#     haml :signup
#   end
#
#   post '/signup/?' do
#     @user = User.create(params[:user])
#     if @user.valid? && @user.id
#       session[:user] = @user.id
#       flash[:notice] = "Account created."
#       redirect '/login'
#     else
#       flash[:error] = "There were some problems creating your account: #{@user.errors}."
#       binding.pry
#       redirect '/signup' # + hash_to_query_string(params['user'])
#     end
#   end
#
#
#
#   get "/login" do
#     haml :login
#   end
#
#   post "/login" do
#     session[:user_id] = User.authenticate(params).id
#   end
#
#   get "/logout" do
#     session[:user_id] = nil
#   end
#
#   helpers do
#
#     def logger
#       request.logger
#     end
#
#     def is_user?
#       @user != nil
#     end
#
#     # def get_background(brand)
#     #   files = Dir.entries( File.join(settings.public_folder, "images", "brands", brand, "backgrounds", @img_res)) rescue []
#     #   files.any? && files.delete(".") && files.delete("..") && files.delete(".DS_Store") #if files.any?
#     #   nr = 0 + rand(files.count)
#     #   nr -= 1 if files.count == nr
#     #   logger.info "found %s files - chose %s" % [files.count,nr]
#     #   "/images/brands/#{brand}/backgrounds/#{@img_res}/#{files[nr]}" rescue ""
#     # end
#     #
#     # def get_width
#     #   case @img_res
#     #   when 'phone'; "480px"
#     #   when 'small'; "768px"
#     #   when 'large'; "768px"
#     #   when 'huge'; "1220px"
#     #   end
#     # end
#
#     def hash_to_query_string(hash)
#       hash.collect {|k,v| "#{k}=#{v}"}.join('&')
#     end
#
#     def login_required
#       #not as efficient as checking the session. but this inits the fb_user if they are logged in
#       user = current_user
#       if user && user.class != GuestUser
#         return true
#       else
#         session[:return_to] = request.fullpath
#         redirect '/login'
#         return false
#       end
#     end
#
#     def current_user
#       if session[:user]
#         User.get(:id => session[:user])
#       else
#         GuestUser.new
#       end
#     end
#
#     def logged_in?
#       !!session[:user]
#     end
#
#     def use_layout?
#       !request.xhr?
#     end
#
#     #BECAUSE sinatra 9.1.1 can't load views from different paths properly
#     def get_view_as_string(filename)
#       view = File.join(settings.sinatra_authentication_view_path, filename)
#       data = ""
#       f = File.open(view, "r")
#       f.each_line do |line|
#         data += line
#       end
#       return data
#     end
#
#     def render_login_logout(html_attributes = {:class => ""})
#     css_classes = html_attributes.delete(:class)
#     parameters = ''
#     html_attributes.each_pair do |attribute, value|
#       parameters += "#{attribute}=\"#{value}\" "
#     end
#
#       result = "<div id='sinatra-authentication-login-logout' >"
#       if logged_in?
#         logout_parameters = html_attributes
#         # a tad janky?
#         logout_parameters.delete(:rel)
#         result += "<a href='/users/#{current_user.id}/edit' class='#{css_classes} sinatra-authentication-edit' #{parameters}>Edit account</a> "
#         if Sinatra.const_defined?('FacebookObject')
#           if fb[:user]
#             result += "<a href='javascript:FB.Connect.logoutAndRedirect(\"/logout\");' class='#{css_classes} sinatra-authentication-logout' #{logout_parameters}>Logout</a>"
#           else
#             result += "<a href='/logout' class='#{css_classes} sinatra-authentication-logout' #{logout_parameters}>Logout</a>"
#           end
#         else
#           result += "<a href='/logout' class='#{css_classes} sinatra-authentication-logout' #{logout_parameters}>Logout</a>"
#         end
#       else
#         result += "<a href='/signup' class='#{css_classes} sinatra-authentication-signup' #{parameters}>Signup</a> "
#         result += "<a href='/login' class='#{css_classes} sinatra-authentication-login' #{parameters}>Login</a>"
#       end
#
#       result += "</div>"
#     end
#
#
#   end
#   #
#   # get '/download/*' do |fil|
#   #   haml :download, locals: { image: '/'+fil.gsub(/\.png/,".jpg") }
#   # end
#   #
#   # get "/map" do
#   #   haml :map
#   # end
#
#   get '/' do
#     haml :map, :format => :html5
#   end
#
#   post '/projects' do
#     project = Project.new
#     project.image = params[:image]
#     project.save
#     redirect to("/projects/#{project.id}")
#   end
#
# end
#
# #require_relative 'iddenim'
#
# ##########################################################
# # works not!
# ##########################################################
# #
# # get '/', :agent => /Songbird (\d\.\d)[\d\/]*?/ do
# #   "You're using Songbird version #{params[:agent][0]}"
# # end
#
# # not_found do
# #   "fejl!"
# # end
#
# # not in development at least - perhaps because Sinatra does strange stuff with error method in development
# #
# # error MyCustomError do
# #   'So what happened was...' + env['sinatra.error'].message
# # end
# #
# # error 400..510 do
# #   'Boom'
# # end
# #
# # get '/' do
# #   raise MyCustomError, '10'
# # end
#
#
# ##########################################################
# # works
# ##########################################################
#
#
# #
# # get '/' do
# #   attachment "info.txt"
# #   "store it!"
# # end
#
# # template :layout do
# #   "%html\n  %body{style: 'background-color: #111'}\n    =yield\n"
# # end
# #
# # template :index do
# #   '%div.title{ style: "background-color: #989afd"} Hello World!'
# # end
# #
# # get '/' do
# #   haml :index, :layout => !request.xhr?
# # end
#
#
# # get '/:id' do
# #   @foo = Employee.find(params[:id])
# #   haml '%h1= @foo.name'
# # end
#
# # get '/' do
# #   haml '%div.title Hello World'
# # end
# #
#
# # get '/' do
# #   code = "<%= Time.now %>"
# #   erb code
# # end
#
#
# # class Stream
# #   def each
# #     10000.times { |i| yield "#{i}\n" }
# #   end
# # end
# #
# # get('/') { Stream.new }
#
