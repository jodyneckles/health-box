
require 'rest-client'
require 'json'
require 'pry'

categories = ["Beef", "Pork", "Chicken", "Lamb", "Seafood", "Pasta", "Vegetarian", "Vegan"]

meals = []

categories.each do |category|
    response = RestClient.get("https://www.themealdb.com/api/json/v1/1/filter.php?c=#{category}")
    json = JSON.parse(response)
    json.each do |meal|
      meals << meal
    end
  end

recipe_details = []
ingredients_list = []

meals.each do |category|
  category_meals = category[1]
    category_meals.each do |meal|
      response = RestClient.get("https://www.themealdb.com/api/json/v1/1/lookup.php?i=#{meal["idMeal"].to_i}")
      json = JSON.parse(response)
      json["meals"][0]["strIngredient1"] = "#{json["meals"][0]["strIngredient1"]} - #{json["meals"][0]["strMeasure1"]}"
      json["meals"][0]["strIngredient2"] = "#{json["meals"][0]["strIngredient2"]} - #{json["meals"][0]["strMeasure2"]}"
      json["meals"][0]["strIngredient3"] = "#{json["meals"][0]["strIngredient3"]} - #{json["meals"][0]["strMeasure3"]}"
      json["meals"][0]["strIngredient4"] = "#{json["meals"][0]["strIngredient4"]} - #{json["meals"][0]["strMeasure4"]}"
      json["meals"][0]["strIngredient5"] = "#{json["meals"][0]["strIngredient5"]} - #{json["meals"][0]["strMeasure5"]}"
      json["meals"][0]["strIngredient6"] = "#{json["meals"][0]["strIngredient6"]} - #{json["meals"][0]["strMeasure6"]}"
      json["meals"][0]["strIngredient7"] = "#{json["meals"][0]["strIngredient7"]} - #{json["meals"][0]["strMeasure7"]}"
      json["meals"][0]["strIngredient8"] = "#{json["meals"][0]["strIngredient8"]} - #{json["meals"][0]["strMeasure8"]}"
      json["meals"][0]["strIngredient9"] = "#{json["meals"][0]["strIngredient9"]} - #{json["meals"][0]["strMeasure9"]}"
      json["meals"][0]["strIngredient10"] = "#{json["meals"][0]["strIngredient10"]} - #{json["meals"][0]["strMeasure10"]}"
      json["meals"][0]["strIngredient11"] = "#{json["meals"][0]["strIngredient11"]} - #{json["meals"][0]["strMeasure11"]}"
      json["meals"][0]["strIngredient12"] = "#{json["meals"][0]["strIngredient12"]} - #{json["meals"][0]["strMeasure12"]}"
      json["meals"][0]["strIngredient13"] = "#{json["meals"][0]["strIngredient13"]} - #{json["meals"][0]["strMeasure13"]}"
      json["meals"][0]["strIngredient14"] = "#{json["meals"][0]["strIngredient14"]} - #{json["meals"][0]["strMeasure14"]}"
      json["meals"][0]["strIngredient15"] = "#{json["meals"][0]["strIngredient15"]} - #{json["meals"][0]["strMeasure15"]}"
      json["meals"][0]["strIngredient16"] = "#{json["meals"][0]["strIngredient16"]} - #{json["meals"][0]["strMeasure16"]}"
      json["meals"][0]["strIngredient17"] = "#{json["meals"][0]["strIngredient17"]} - #{json["meals"][0]["strMeasure17"]}"
      json["meals"][0]["strIngredient18"] = "#{json["meals"][0]["strIngredient18"]} - #{json["meals"][0]["strMeasure18"]}"
      json["meals"][0]["strIngredient19"] = "#{json["meals"][0]["strIngredient19"]} - #{json["meals"][0]["strMeasure19"]}"
      json["meals"][0]["strIngredient20"] = "#{json["meals"][0]["strIngredient20"]} - #{json["meals"][0]["strMeasure20"]}"
      recipe_details << json["meals"][0]
      ingredients_list << json["meals"][0]["strIngredient1"]
      ingredients_list << json["meals"][0]["strIngredient2"]
      ingredients_list << json["meals"][0]["strIngredient3"]
      ingredients_list << json["meals"][0]["strIngredient4"]
      ingredients_list << json["meals"][0]["strIngredient5"]
      ingredients_list << json["meals"][0]["strIngredient6"]
      ingredients_list << json["meals"][0]["strIngredient7"]
      ingredients_list << json["meals"][0]["strIngredient8"]
      ingredients_list << json["meals"][0]["strIngredient9"]
      ingredients_list << json["meals"][0]["strIngredient10"]
      ingredients_list << json["meals"][0]["strIngredient11"]
      ingredients_list << json["meals"][0]["strIngredient12"]
      ingredients_list << json["meals"][0]["strIngredient13"]
      ingredients_list << json["meals"][0]["strIngredient14"]
      ingredients_list << json["meals"][0]["strIngredient15"]
      ingredients_list << json["meals"][0]["strIngredient16"]
      ingredients_list << json["meals"][0]["strIngredient17"]
      ingredients_list << json["meals"][0]["strIngredient18"]
      ingredients_list << json["meals"][0]["strIngredient19"]
      ingredients_list << json["meals"][0]["strIngredient20"]
    end
end

# Create unique ingredients list and seed ingredients table

ingredients_list.delete(" - ")

ingredient_names = ingredients_list.uniq.sort

ingredient_names.each do |name|
  Ingredient.create(name: name)
end

ingredient_ref_hash = {}

Ingredient.all.each do |ingredient|
  ingredient_ref_hash[ingredient.name] = ingredient.id.to_i
end

recipe_details.each do |recipe|
  recipe.each do |key, value|
    if key.include?("Ingredient")
      recipe[key] = ingredient_ref_hash[value]
    end
  end
end

recipe_details.each do |recipe|
  Recipe.create(name: recipe["strMeal"], category: recipe["strCategory"], instructions: recipe["strInstructions"], image: recipe["strMealThumb"], video: recipe["strYoutube"] )
end

recipe_details.each do |recipe|
  recipe_db = Recipe.find_by(name: recipe["strMeal"])
  recipe.each do |key, value|
    if key.include?("Ingredient")
      RecipeIngredient.create(recipe_id: recipe_db["id"], ingredient_id: value)
    end
  end
end
