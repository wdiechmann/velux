APP_ROOT ||= "/Users/walther/Documents/Projects/Rails/velux"
class ProjectScreen < Sinatra::Base

  register Sinatra::Flash
  register Sinatra::StaticAssets

  CarrierWave.root = File.join APP_ROOT, "public"

  # before do
  #   if request.path_info =~ /project/ && session['user_name'].nil?
  #     redirect '/login'
  #   end
  # end

  get "/projects" do
    #?q=anders
    @project = Project.all.where("title like ?","%#{params[:q]}%").first
    haml :project_new
  end

  get "/projects/new" do
    @project ||= Project.new
    haml :project_new
  end

  get "/projects/:id" do |id|
    @project = Project.find(id)
    haml :project_new
  end

  post "/projects" do
    fp = params[:project][:image].blank? ? nil : File.join( APP_ROOT,'public/images/uploads', params[:project][:image] )
    @project = Project.create(params[:project])
    if @project

      if @project.valid?
        @project.geolocate
        @project.image = File.open( fp ) unless fp.nil?
        if @project.save!
          # redirect to("/projects/#{@project.id}")
          haml :project_new
        else
          flash[:error] = "der var et problem med at oprette projektet!"
          # redirect back
          haml :project_new
        end
      else
        flash[:error] = "der var et problem med at oprette projektet!"
        # redirect back
        haml :project_new
      end
    else
      flash[:error] = "der var et problem med at oprette projektet!"
      @project ||= Project.new
      haml :project_new
    end
  end

  put "/projects" do
    @project = Project.find(params["project"]["id"])
    if params["project"]["image"] != ""
      fp = File.join( APP_ROOT,'public/images/uploads', params[:project][:image] )
    else
      fp = nil
    end
    puts params
    state = false
    if @project.update_attributes(params["project"])
      @project.geolocate
      @project.image = File.open( fp ) if fp
      state = true
    end
    if state && @project.save!
      redirect to("/projects/#{@project.id}")
    else
      flash[:error] = "der var et problem med at opdatere projektet!"
      redirect back
    end
  end

end
