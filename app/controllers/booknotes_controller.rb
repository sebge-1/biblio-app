class BooknotesController < ApplicationController
  get '/create_booknote' do
    if current_user.logged_in
      erb :'/booknotes/create_booknote'
    else
      redirect '/login'
    end
  end

end
