class User

  has_many :booknotes
  has_many :book, through: :booknotes
  
  # has_secure_password **make sure you have right gem**

end
