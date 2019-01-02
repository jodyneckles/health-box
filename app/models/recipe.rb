class Recipe < ApplicationRecord
  has_many :orders
  has_many :users, through: :orders
  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients
end
