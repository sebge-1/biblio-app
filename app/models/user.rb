class User  < ActiveRecord::Base

  has_many :booknotes
  has_many :books, through: :booknotes

  validates :username, presence: true
    # { message: "Mmh, looks like you missed something here."}
  validates :username, uniqueness: true
  # { message: "Aw, that one's gone. Try another."}
  validates :password, presence: true
  # { message: "Better fill that in."}
  validates_strength_of :password
  # { message: "Mix some numbers and letters together."}
  has_secure_password
end
