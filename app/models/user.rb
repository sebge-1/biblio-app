class User  < ActiveRecord::Base

  has_many :booknotes
  has_many :books, through: :booknotes

  validates :username, presence: { message: "Mmh, looks like you missed something here."}
  validates_uniqueness_of :username, { message: "Aw, that username's gone. Try another."}
  has_secure_password validations: false
  validates_strength_of :password, { message: "Your password should contain numbers, letters and special characters"}

end
