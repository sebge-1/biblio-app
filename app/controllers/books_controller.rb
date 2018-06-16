class BooksController < ApplicationController

  get '/books' do
    if logged_in?
      @books = Book.all
      erb :'/books/index'
    else
      '/'
    end
  end

  get '/books/new' do
    if logged_in?
      erb :'/books/new'
    else
      '/'
    end
  end

  post '/books' do
    @user = current_user
    if logged_in?
      if !params[:title].empty? && !params[:author].empty? #don't allow empty zombie books
        @book = Book.create(title: params[:title], author: params[:author])
        @user.books << @book
        redirect "/books/#{@book.id}"
      else
        redirect '/books/new'
      end
    else
      '/'
    end
  end

  get '/books/:id' do
    @book = Book.find_by_id(params[:id])
    @booknote = Booknote.find_by(book_id: @book.id)
    if current_user.booknotes.include?(@booknote)
      redirect "/booknotes/#{@booknote.id}"
    else
      erb :'books/show'
    end
  end

  get '/books/:id/edit' do
    @book = Book.find_by(id: params[:id])
    if logged_in? && current_user.books.include?(@book)
      erb :'/books/edit'
    else
      '/'
    end
  end

  patch '/books/:id' do
    if logged_in? && current_user.books.include?(@book)
      @book = Book.find_by(id: params[:id])
      @book.update(title: params[:title], author: [params[:author]])
    else
      '/'
    end
  end

  delete '/books/:id/delete' do
    @book = Book.find_by(id: params[:id])
    if logged_in? && current_user.books.include?(@book)
      @book.destroy
    end
    redirect '/'
  end

end
