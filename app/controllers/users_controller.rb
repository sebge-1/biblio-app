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

  get '/users/:id' do
    @user = current_user
    erb :'/users/show'
  end

end
