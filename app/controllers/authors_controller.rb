class AuthorsController < ApplicationController

  get '/authors' do
    @user = current_user
    @authors = @user.books.map{ |book| book.author}.uniq
    erb :'/authors/index'
  end

  get '/authors/:id' do
    @author = Author.find_by(id: params[:id])
    erb :'/authors/show'
  end

end
