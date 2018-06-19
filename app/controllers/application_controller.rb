require './config/environment'
# require 'rack-flash'
require 'sinatra/flash'

class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions # required to store session[:id]
    # use Rack::Flash
    register Sinatra::Flash
    set :session_secret, "secret"
  end

  get '/' do
    if logged_in?
      @user = current_user
      redirect "/users/#{@user.id}"
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
