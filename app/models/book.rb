class Book
  has_many :booknotes
  has_many :users, through: :booknotes

end
