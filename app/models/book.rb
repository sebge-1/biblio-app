class Book < ActiveRecord::Base
  has_many :book_users
  has_many :users, through: :book_users
  has_many :booknotes

  validates :title, presence: :true
  validates :author, presence: :true
end
