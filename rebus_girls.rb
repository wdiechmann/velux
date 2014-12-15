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


  namespace "/rebus_girls" do
  
    get "" do
      haml :brand_front, :format => :html5, locals: { :brand => 'rebus_girls'}
    end

    # sæsoner
    # --------------------------------------------
    # get "/fair_13" do
    #   files = Dir.entries( File.join(settings.public_folder, "images", "brands", "rebus_girls", "collections", "fair_13", @img_res)) rescue []
    #   haml :brand_collection, :format => :html5, locals: { :files => files, :brand => 'rebus_girls', :season => "fair_13"  }
    # end
    # 
    # get "/express_august_12" do
    #   files = Dir.entries( File.join(settings.public_folder, "images", "brands", "rebus_girls", "collections", "express_august_12", @img_res)) rescue []
    #   haml :brand_collection, :format => :html5, locals: { :files => files, :brand => 'rebus_girls', :season => "express-august_12" }
    # end
    #   
    # get "/fall_14" do
    #   files = Dir.entries( File.join(settings.public_folder, "images", "brands", "rebus_girls", "collections", "fall_14", @img_res)) rescue []
    #   haml :brand_collection, :format => :html5, locals: { :files => files, :brand => 'rebus_girls', :season => "fall_14" }
    # end
    #   
    # get "/x-mas_13" do
    #   files = Dir.entries( File.join(settings.public_folder, "images", "brands", "rebus_girls", "collections", "x_mas_13", @img_res)) rescue []
    #   haml :brand_collection, :format => :html5, locals: { :files => files, :brand => 'rebus_girls', :season => "x_mas_13" }
    # end
    #   
    # get "/high_summer_13" do
    #   files = Dir.entries( File.join(settings.public_folder, "images", "brands", "rebus_girls", "collections", "high_summer_13", @img_res)) rescue []
    #   haml :brand_collection, :format => :html5, locals: { :files => files, :brand => 'rebus_girls', :season => "high_summer_13" }
    # end
    #
    # get "/express_feb_14" do
    #   files = Dir.entries( File.join(settings.public_folder, "images", "brands", "rebus_girls", "collections", "express_feb_14", @img_res)) rescue []
    #   haml :brand_collection, :format => :html5, locals: { :files => files, :brand => 'rebus_girls', :season => "express_feb_14"  }
    # end
    #
    # get "/spring_14" do
    #   files = Dir.entries( File.join(settings.public_folder, "images", "brands", "rebus_girls", "collections", "spring_14", @img_res)) rescue []
    #   haml :brand_collection, :format => :html5, locals: { :files => files, :brand => 'rebus_girls', :season => "spring_14" }
    # end

    get "/high_summer_14" do
      files = Dir.entries( File.join(settings.public_folder, "images", "brands", "rebus_girls", "collections", "high_summer_14", @img_res)) rescue []
      haml :brand_collection, :format => :html5, locals: { :files => files, :brand => 'rebus_girls', :season => "high_summer_14" }
    end

    get "/express_aug_14" do
      files = Dir.entries( File.join(settings.public_folder, "images", "brands", "rebus_girls", "collections", "express_aug_14", @img_res)) rescue []
      haml :brand_collection, :format => :html5, locals: { :files => files, :brand => 'rebus_girls', :season => "express_aug_14" }
    end

    get "/fall_14" do
      files = Dir.entries( File.join(settings.public_folder, "images", "brands", "rebus_girls", "collections", "fall_14", @img_res)) rescue []
      haml :brand_collection, :format => :html5, locals: { :files => files, :brand => 'rebus_girls', :season => "fall_14" }
    end

    get "/x-mas_14" do
      files = Dir.entries( File.join(settings.public_folder, "images", "brands", "rebus_girls", "collections", "x_mas_14", @img_res)) rescue []
      haml :brand_collection, :format => :html5, locals: { :files => files, :brand => 'rebus_girls', :season => "x_mas_14" }
    end

    # --------------------------------------------
    #

  
    get "/jeans" do
      haml :jeans, :format => :html5, locals: { :brand => 'rebus_girls'}
    end
  
    get "/basics" do
      models = Dir.entries( File.join(settings.public_folder, "images", "brands", "rebus_girls", "basic", @img_res)) rescue []
      haml :brand_basics, :format => :html5, locals: { :models => models, :brand => 'rebus_girls', :subfolder => 'basic' }
    end
  
    get "/socks" do
      models = Dir.entries( File.join(settings.public_folder, "images", "brands", "rebus_girls", "socks", @img_res)) rescue []
      haml :brand_basics, :format => :html5, locals: { :models => models, :brand => 'rebus_girls', :subfolder => 'socks' }
    end
  
    get "/underwear" do
      models = Dir.entries( File.join(settings.public_folder, "images", "brands", "rebus_girls", "underwear", @img_res)) rescue []
      haml :brand_basics, :format => :html5, locals: { :models => models, :brand => 'rebus_girls', :subfolder => 'underwear' }
    end
  
  end

end
