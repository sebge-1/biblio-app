class User  < ActiveRecord::Base

  has_many :booknotes
  has_many :books, through: :booknotes

  validates :username, presence: {"Mmh, looks like you missed something here."}
  validates :username, uniqueness: {"Aw, that one's gone. Try another."}
  validates :password, presence: {"Better fill that in."}
  validates_strength_of :password
  has_secure_password
end
