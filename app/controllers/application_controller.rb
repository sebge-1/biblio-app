require './config/environment'
class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions # required to store session[:id]
    set :session_secret, "secret"
  end

  get '/' do
    if logged_in?
      erb :'users/show'
    else
      erb :index
    end
  end

  def logged_in?
    !!session[:id]
  end

  def current_user
    User.find(session[:id])
  end
end
