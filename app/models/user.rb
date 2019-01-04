class User < ApplicationRecord
  has_many :orders
  has_many :recipies, through: :orders
  has_secure_password

  validates :gender, :first_name, :last_name, :address, presence: true
  validates :username, uniqueness: true
  validates :phone_number, :format => {
                                      :with => /\A(((\+44\s?\d{4}|\(?0\d{4}\)?)\s?\d{3}\s?\d{3})|((\+44\s?\d{3}|\(?0\d{3}\)?)\s?\d{3}\s?\d{4})|((\+44\s?\d{2}|\(?0\d{2}\)?)\s?\d{4}\s?\d{4}))(\s?\#(\d{4}|\d{3}))?\z/,
                                      message: "- please enter a telephone number with 11 digits"
                                      }
  validates :password, :format => {
                                  :with => /\A(?=.*[a-zA-Z])(?=.*[0-9]).{8,}\z/,
                                  message: "- must be at least 8 characters and include one number and one letter."
                                  }

  GENDER_TYPES = ["","Mr","Mrs","Miss","Mx","Dr"]
end
