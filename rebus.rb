# encoding: UTF-8
#/* - - - - - - - - - - - - - - - - - - - - -
#
#   Title : WEB Appliances Crest Inc, Web Form Framework
#   Author : Enrique Phillips 
#   URL : http://www.wac.bz
#
#- - - - - - - - - - - - - - - - - - - - - */
require "sinatra/namespace"
class LanielApp < Sinatra::Base

  register Sinatra::Namespace


  namespace "/rebus" do
  
    get "" do
      haml :brand_front, :format => :html5, locals: { :brand => 'rebus'}
    end

    # sæsoner
    # --------------------------------------------
    # get "/fair_13" do
    #   files = Dir.entries( File.join(settings.public_folder, "images", "brands", "rebus", "collections", "fair_13", @img_res)) rescue []
    #   haml :brand_collection, :format => :html5, locals: { :files => files, :brand => 'rebus', :season => "fair_13"  }
    # end
    # 
    # get "/express_august_12" do
    #   files = Dir.entries( File.join(settings.public_folder, "images", "brands", "rebus", "collections", "express_august_12", @img_res)) rescue []
    #   haml :brand_collection, :format => :html5, locals: { :files => files, :brand => 'rebus', :season => "express-august_12" }
    # end
    #   
    # get "/fall_14" do
    #   files = Dir.entries( File.join(settings.public_folder, "images", "brands", "rebus", "collections", "fall_14", @img_res)) rescue []
    #   haml :brand_collection, :format => :html5, locals: { :files => files, :brand => 'rebus', :season => "fall_14" }
    # end
    #   
    # get "/x-mas_13" do
    #   files = Dir.entries( File.join(settings.public_folder, "images", "brands", "rebus", "collections", "x_mas_13", @img_res)) rescue []
    #   haml :brand_collection, :format => :html5, locals: { :files => files, :brand => 'rebus', :season => "x_mas_13" }
    # end
    #   
    # get "/high_summer_13" do
    #   files = Dir.entries( File.join(settings.public_folder, "images", "brands", "rebus", "collections", "high_summer_13", @img_res)) rescue []
    #   haml :brand_collection, :format => :html5, locals: { :files => files, :brand => 'rebus', :season => "high_summer_13" }
    # end
    #
    # get "/express_feb_14" do
    #   files = Dir.entries( File.join(settings.public_folder, "images", "brands", "rebus", "collections", "express_feb_14", @img_res)) rescue []
    #   haml :brand_collection, :format => :html5, locals: { :files => files, :brand => 'rebus', :season => "express_feb_14"  }
    # end
    #
    # get "/spring_14" do
    #   files = Dir.entries( File.join(settings.public_folder, "images", "brands", "rebus", "collections", "spring_14", @img_res)) rescue []
    #   haml :brand_collection, :format => :html5, locals: { :files => files, :brand => 'rebus', :season => "spring_14" }
    # end

    get "/high_summer_14" do
      files = Dir.entries( File.join(settings.public_folder, "images", "brands", "rebus", "collections", "high_summer_14", @img_res)) rescue []
      haml :brand_collection, :format => :html5, locals: { :files => files, :brand => 'rebus', :season => "high_summer_14" }
    end

    get "/fall_14" do
      files = Dir.entries( File.join(settings.public_folder, "images", "brands", "rebus", "collections", "fall_14", @img_res)) rescue []
      haml :brand_collection, :format => :html5, locals: { :files => files, :brand => 'rebus', :season => "fall_14" }
    end

    # --------------------------------------------
    #

  
    get "/jeans" do
      haml :jeans, :format => :html5, locals: { :brand => 'rebus'}
    end
  
    get "/girls_basics" do
      models = Dir.entries( File.join(settings.public_folder, "images", "brands", "rebus", "girls_basic", @img_res)) rescue []
      haml :brand_basics, :format => :html5, locals: { :models => models, :brand => 'rebus', :subfolder => 'girls_basic' }
    end
  
    get "/girls_socks" do
      models = Dir.entries( File.join(settings.public_folder, "images", "brands", "rebus", "girls_socks", @img_res)) rescue []
      haml :brand_basics, :format => :html5, locals: { :models => models, :brand => 'rebus', :subfolder => 'girls_socks' }
    end
  
    get "/girls_underwear" do
      models = Dir.entries( File.join(settings.public_folder, "images", "brands", "rebus", "girls_underwear", @img_res)) rescue []
      haml :brand_basics, :format => :html5, locals: { :models => models, :brand => 'rebus', :subfolder => 'girls_underwear' }
    end
  
    get "/boys_basics" do
      models = Dir.entries( File.join(settings.public_folder, "images", "brands", "rebus", "boys_basic", @img_res)) rescue []
      haml :brand_basics, :format => :html5, locals: { :models => models, :brand => 'rebus', :subfolder => 'boys_basic' }
    end
  
    get "/boys_socks" do
      models = Dir.entries( File.join(settings.public_folder, "images", "brands", "rebus", "boys_socks", @img_res)) rescue []
      haml :brand_basics, :format => :html5, locals: { :models => models, :brand => 'rebus', :subfolder => 'boys_socks' }
    end
  
    get "/boys_underwear" do
      models = Dir.entries( File.join(settings.public_folder, "images", "brands", "rebus", "boys_underwear", @img_res)) rescue []
      haml :brand_basics, :format => :html5, locals: { :models => models, :brand => 'rebus', :subfolder => 'boys_underwear' }
    end
  
    # GET /rebus/basics_muster?muster=sample_27127_370.png
    get "/basics_muster" do
      haml :basics_muster, locals: { :muster => params[:muster], :brand => 'rebus', :subfolder => params[:subfolder] }
    end

  end

end
