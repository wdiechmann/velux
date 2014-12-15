# encoding: UTF-8
#/* - - - - - - - - - - - - - - - - - - - - -
#
#   Title : WEB Appliances Crest Inc, Web Form Framework
#   Author : Enrique Phillips 
#   URL : http://www.wac.bz
#
#- - - - - - - - - - - - - - - - - - - - - */
require "sinatra/namespace"
# require "pry"
class LanielApp < Sinatra::Base

  register Sinatra::Namespace

  namespace "/fbi" do

    get "/puzzle" do
      haml :puzzle
    end

  end

  get '/' do
    haml :fb_index, :format => :html5
  end


end
