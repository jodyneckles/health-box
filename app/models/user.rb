class User < ApplicationRecord
  has_many :orders
  has_many :recipies, through: :orders
  has_secure_password

  validates :gender, presence: true
  validates :username, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :phone_number, presence: true
  validates :address, presence: true
  validates :password, :format => {
                                  :with => /\A(?=.*[a-zA-Z])(?=.*[0-9]).{8,}\z/,
                                  message: "must be at least 8 characters and include one number and one letter."
                                  }

  GENDER_TYPES = ["Mr","Mrs","Miss","Mx","Dr"]
end
