class User < ApplicationRecord
  has_many :orders
  has_many :recipies, through: :orders
end
