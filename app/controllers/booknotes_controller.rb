require 'pry'

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
    redirect "/books/#{@book.id}"
  end

end
