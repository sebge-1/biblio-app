class User  < ActiveRecord::Base

  has_many :booknotes
  has_many :book, through: :booknotes

  has_secure_password
end
