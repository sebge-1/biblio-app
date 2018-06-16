class UsersController < ApplicationController

  get '/signup' do
    erb :'/users/signup'
  end

  post '/signup' do
    @user = User.new(username: params[:username], password: params[:password])
    if @user.save
      session[:id] = @user.id
      redirect "/users/#{@user.id}"
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
      redirect "/users/#{@user.id}"
    else
      set_error_message
      erb :index
    end
  end

  get '/users/:id' do
    @user = current_user
    if logged_in?
      erb :'/users/show'
    end
  end

end
