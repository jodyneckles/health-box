class RecipesController < ApplicationController

before_action :find_recipe, only: [:show]

  def index
    @recipes = Recipe.all
    @categories = Recipe.all.map(&:category).uniq
  end

  def show
    ingredient_ids = RecipeIngredient.where(recipe_id: params[:id])
    @ingredients = []
    ingredient_ids.each do |ingredient|
      @ingredients << Ingredient.find(ingredient.ingredient_id)
    end
  end

  def search
    if params[:recipe][:category] == ""
      @recipes = Recipe.all
    else
      @recipes = Recipe.where(category: params[:recipe][:category])
    end
    @categories = Recipe.all.map(&:category).uniq
    render 'index'
  end

  private

  def find_recipe
    @recipe = Recipe.find(params[:id])
  end

end
