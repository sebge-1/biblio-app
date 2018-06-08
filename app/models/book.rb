class Book < ActiveRecord::Base
  has_many :users
  has_many :booknotes, through: :users
end
