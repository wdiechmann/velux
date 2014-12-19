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
class VeluxApp < Sinatra::Base

  get '/' do
    haml :velux_index, :format => :html5
  end


end
