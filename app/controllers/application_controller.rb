require './config/environment'
class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions # required to store session[:id]
    set :session_secret, "secret"
  end

  get '/' do
    erb :index
  end
end
