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
      redirect '/users/#{current_user.id}'
    else
      erb :index
    end
  end

  helpers do
    def logged_in?
      !!session[:id]
    end

    def current_user
      User.find_by(id: session[:id])
    end

    def set_error_message
      if params[:username].blank? && params[:password].blank?
        @error_message = "Please enter something."
      elsif @user.nil?
        @error_message = "We don't seem to know about you."
      elsif !@user.authenticate(params[:password])
        @error_message = "Wrong password. Try again."
      end
    end
  end

end
