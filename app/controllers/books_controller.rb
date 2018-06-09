class BooksController < ApplicationController

  get '/books/new' do
    erb :'/books/new'
  end

  post '/books' do
    @user = current_user
    if !params[:title].empty? && !params[:author].empty? #don't allow empty zombie books
      @book = Book.new(title: params[:title], author: params[:author])
      @user.books << @book
      redirect "/users/#{@user.id}"
    else
      redirect '/books/new'
    end
  end

end
