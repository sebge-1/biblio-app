class Book < ActiveRecord::Base
  has_many :booknotes
  has_many :users, through: :booknotes
end
