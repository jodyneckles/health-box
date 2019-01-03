class RecipesController < ApplicationController

before_action :find_recipe, only: [:show]

  def index
    @recipes = Recipe.all
  end

  def show
    ingredient_ids = RecipeIngredient.where(recipe_id: params[:id])
    @ingredients = []
    ingredient_ids.each do |ingredient|
      @ingredients << Ingredient.find(ingredient.ingredient_id)
    end
  end

  private

  def find_recipe
    @recipe = Recipe.find(params[:id])
  end

end
