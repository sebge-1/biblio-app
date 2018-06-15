class BooknotesController < ApplicationController

  # get '/create_booknote' do
  #   if current_user.logged_in
  #     erb :'/booknotes/create_booknote'
  #   else
  #     redirect '/login'
  #   end
  # end

  post '/books/:id/booknotes' do
    @book = Book.find_by_id(params[:id])
    @booknote = Booknote.create(summary: params[:summary], main_premise: params[:main_premise], book_id: @book.id)
    @book.booknotes << @booknote
    redirect "/booknotes/#{@booknote.id}"
  end

  get '/booknotes/:id' do
    @booknote = Booknote.find_by(id: params[:id])
    erb :'/booknotes/show'
  end

  get '/booknotes/:id/edit' do
    @booknote = Booknote.find_by(id: params[:id])
    erb :'/booknotes/edit'
  end

  patch '/booknotes/:id' do
    @booknote = Booknote.find_by(id: params[:id])
    @booknote.update(summary: params[:summary], main_premise: params[:main_premise])
    redirect "/booknotes/#{@booknote.id}"
  end

end
