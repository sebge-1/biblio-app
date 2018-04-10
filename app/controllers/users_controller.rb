class UsersController < ApplicationController

  get '/signup' do
    erb :'/users/signup'
  end

  post '/signup' do
    @user = User.new(username: params[:username], password: params[:password])
    if @user.save
      session[:id] = @user.id
      redirect '/users/show'
    else
      erb :'/users/signup'
    end
  end

  get '/users/show' do
    @user = User.find_by_id(session[:id])
    erb :'/users/show'
  end
end
