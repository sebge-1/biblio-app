class BooksController < ApplicationController

  get '/books/new' do
    erb :'/books/new'
  end

  post '/books' do
    @user = current_user
    if !params[:title].empty? && !params[:author].empty? #don't allow empty zombie books
      @book = Book.new(title: params[:title], author: params[:author])
      @user.books << @book
      redirect "/books/#{@book.id}"
    else
      redirect '/books/new'
    end
  end

  get '/books/:id' do
    @book = current_user.books.last
    erb :'books/show'
  end

end
