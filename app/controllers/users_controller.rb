class UsersController < ApplicationController

  get '/signup' do
    erb :'/users/signup'
  end

  post '/signup' do
    @user = User.new(username: params[:username], password: params[:password])
    if @user.save
      session[:id] = @user.id
      redirect '/users/:id'
    else
      erb :'/users/signup'
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
    end
    redirect '/'
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:id] = @user.id
      redirect '/users/:id'
    else
      if params[:username].blank? && params[:password].blank?
        @error_message = "Please enter something."
      elsif @user.nil?
        @error_message = "We don't seem to know about you."
      elsif !@user.authenticate(params[:password])
        @error_message = "Wrong password. Try again."
      end
      erb :index
    end
  end

  get '/users/:id' do
    @user = current_user
    erb :'/users/show'
  end

end
