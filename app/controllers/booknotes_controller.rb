class BooknotesController < ApplicationController

  get '/books/:id/booknotes/new' do
    if logged_in?
      @book = Book.find_by_id(params[:id])
      erb :'/booknotes/new'
    else
      redirect '/'
    end
  end

  post '/books/:id/booknotes' do
    @book = Book.find_by_id(params[:id])
    if logged_in? && current_user.books.include?(@book)
      @booknote = Booknote.create(summary: params[:summary], quotes: params[:quotes], book_id: @book.id)
      if @booknote.valid?
        @book.booknotes << @booknote
        redirect "/booknotes/#{@booknote.id}"
      else
        flash[:error] = @booknote.errors[:base][0]
        redirect "/books/#{@book.id}/booknotes/new"
      end
    else
      redirect '/'
    end
  end

  get '/booknotes/:id' do
    @user = current_user
    @booknote = Booknote.find_by(id: params[:id])
    erb :'/booknotes/show'
  end

  get '/booknotes/:id/edit' do
    @booknote = Booknote.find_by(id: params[:id])
    if logged_in? && current_user.booknotes.include?(@booknote)
      erb :'/booknotes/edit'
    else
      redirect '/'
    end
  end

  patch '/booknotes/:id' do
    @booknote = Booknote.find_by(id: params[:id])
    @book = Book.find_by(id: @booknote.book_id)
    if logged_in? && current_user.booknotes.include?(@booknote)
      @booknote.update(summary: params[:summary], quotes: params[:quotes], research: params[:research])
      
      if @booknote.valid?
        @book.booknotes << @booknote
        redirect "/booknotes/#{@booknote.id}"
      else
        flash[:error] = @booknote.errors[:base][0]
        redirect "/booknotes/#{@book.id}/edit"
      end
    else
      redirect '/'
    end
  end

  delete '/booknotes/:id/delete' do
    @booknote = Booknote.find_by(id: params[:id])
    if logged_in? && current_user.booknotes.include?(@booknote)
      @booknote.delete
      redirect "/users/#{current_user.id}"
    else
      redirect '/'
    end
  end

end
