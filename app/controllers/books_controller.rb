class BooksController < ApplicationController

  get '/books' do
    if logged_in?
      @books = Book.all
      erb :'/books/index'
    else
      redirect '/'
    end
  end

  get '/books/new' do
    if logged_in?
      erb :'/books/new'
    else
      redirect '/'
    end
  end

  post '/books' do
    @user = current_user
    if logged_in?
      if !params[:title].empty? && !params[:author_name].empty? #don't allow empty zombie books
        @author = Author.find_or_create_by(name: params[:author_name])
        @book = Book.create(title: params[:title], author_name: @author.name)
        @user.books << @book
        @author.books << @book
        redirect "/books/#{@book.id}"
      else
        if params[:title].blank? && params[:author].blank?
          flash[:error] = 'Title and author cannot be blank'
        elsif params[:title].blank?
          flash[:error] = 'Title cannot be blank'
        else
          flash[:error] = "Author cannot be blank"
        end   
        redirect '/books/new'
      end
    else
      redirect '/'
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
      redirect '/'
    end
  end

  patch '/books/:id' do
    @book = Book.find_by(id: params[:id])
    @author = Author.find_by(name: @book.author.name)
    if logged_in? && current_user.books.include?(@book)
      @book.update(title: params[:title])
      @author.update(name: params[:author_name])
    end
    redirect '/'
  end

  delete '/books/:id/delete' do
    @book = Book.find_by(id: params[:id])
    if logged_in? && current_user.books.include?(@book)
      @book.destroy
    end
    redirect '/'
  end

  get '/books/:id/add' do
    @book = Book.find_by(id: params[:id])
    @copy = Book.new(title: @book.title, author_name: @book.author_name)
    current_user.books << @copy
    redirect '/'
  end

end
