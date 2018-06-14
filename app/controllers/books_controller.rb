class BooksController < ApplicationController

  get '/books/new' do
    erb :'/books/new'
  end

  post '/books' do
    @user = current_user
    if !params[:title].empty? && !params[:author].empty? #don't allow empty zombie books
      @book = Book.create(title: params[:title], author: params[:author])
      @user.books << @book
      redirect "/books/#{@book.id}"
    else
      redirect '/books/new'
    end
  end

  get '/books/:id' do
    @book = Book.find_by_id(params[:id])
    @booknote = Booknote.find_by(book_id: @book.id)
    erb :'books/show'
  end

end
