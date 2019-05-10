class UsersController < ApplicationController

  get '/signup' do
    erb :'/users/signup'
  end

  post '/signup' do
    @user = User.new(username: params[:username], password: params[:password])
    if @user.save
      session[:id] = @user.id
      redirect "/users/#{@user.id}"
    elsif @user.errors.include?(:username)      
      message = @user.errors.full_messages_for(:username)[0]
      message.slice! "Username"
      flash[:user_error] = message
      redirect '/signup'
    elsif @user.errors.include?(:password)
      message = @user.errors.full_messages_for(:password)[0]
      message.slice! "Password"
      flash[:password_error] = message
      redirect '/signup'
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
      flash[:error] = set_error_message
      redirect '/'
    end
  end

  get '/users/:id' do
    @user = current_user
    if logged_in?
      erb :'/users/show'
    end
  end

end
