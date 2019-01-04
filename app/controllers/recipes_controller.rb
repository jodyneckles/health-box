class RecipesController < ApplicationController

<<<<<<< HEAD
before_action :find_recipe, only: [:show]

  def index
    @recipes = Recipe.all
    @categories = Recipe.all.map(&:category).uniq
  end

  def show
=======
before_action :find_recipe, only: [:show, :edit]
before_action :get_categories, only: [:index, :edit]

  def index
    @recipes = Recipe.all.sort_by(&:name)
  end

  def create
    @recipe = Recipe.new(recipe_params)
    return redirect_to recipes_path unless @recipe.save
    ingredients = params[:recipe][:ids]
    ingredients.shift
    ingredients.each do |ing_id|
      RecipeIngredient.create(recipe_id: @recipe.id, ingredient_id: ing_id)
    end
    redirect_to recipe_path(@recipe)
  end

  def show
    @order = Order.new
>>>>>>> b4dca75c1027bc9089a03f8d119510119e773676
    ingredient_ids = RecipeIngredient.where(recipe_id: params[:id])
    @ingredients = []
    ingredient_ids.each do |ingredient|
      @ingredients << Ingredient.find(ingredient.ingredient_id)
    end
  end

  def search
    if params[:recipe][:category] == ""
<<<<<<< HEAD
      @recipes = Recipe.all
    else
      @recipes = Recipe.where(category: params[:recipe][:category])
    end
    @categories = Recipe.all.map(&:category).uniq
    render 'index'
  end

=======
      @recipes = Recipe.all.sort_by(&:name)
    else
      @recipes = Recipe.where(category: params[:recipe][:category]).sort_by(&:name)
    end
    get_categories
    render 'index'
  end

  def edit
  end

>>>>>>> b4dca75c1027bc9089a03f8d119510119e773676
  private

  def find_recipe
    @recipe = Recipe.find(params[:id])
  end

<<<<<<< HEAD
=======
  def get_categories
    @categories = Recipe.all.map(&:category).uniq
  end

  def recipe_params
    params.require(:recipe).permit(:name, :category, :instructions)
  end

>>>>>>> b4dca75c1027bc9089a03f8d119510119e773676
end
