class LoginScreen < Sinatra::Base
  enable :sessions

  get('/login') { haml :login }

  post('/login') do
    # if params[:name] == 'velux!projects' && params[:password] == 'fönster!'
    if params[:name] == 'velux' && params[:password] == 'velux'
      session['user_name'] = params[:name]
    else
      redirect '/login'
    end
  end
end
