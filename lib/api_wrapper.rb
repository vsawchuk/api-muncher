require 'httparty'
require 'awesome_print'

class ApiWrapper
  BASE_URL = "https://api.edamam.com/"
  APP_ID = ENV["EDAMAM_APPLICATION_ID"]
  APP_KEY = ENV["EDAMAM_APPLICATION_KEY"]

  def self.list_recipes(search, page=1)
    url = BASE_URL + "/search?q=#{search}&app_id=#{APP_ID}&app_key=#{APP_KEY}&from=#{(page - 1) * 10}"
    data = HTTParty.get(url).parsed_response
    recipe_list = []
    if data["hits"]
      data["hits"].each do |recipe_data|
        recipe_list << indexed_recipe(recipe_data)
      end
    end
    return {recipes: recipe_list, count: data["count"]}
  end

  def self.find_recipe(recipe)
    url = BASE_URL + "/search?q=#{recipe}&app_id=#{APP_ID}&app_key=#{APP_KEY}"
    data = HTTParty.get(url).parsed_response
    if data["hits"]
      return shown_recipe(data["hits"].first)
    else
      return nil
    end
  end

  private

  def self.indexed_recipe(api_params)
    return IndexedRecipe.new(
      api_params["recipe"]["label"],
      {
        image: api_params["recipe"]["image"]
      }
    )
  end

  def self.shown_recipe(api_params)
    return ShownRecipe.new(
      api_params["recipe"]["label"],
      api_params["recipe"]["url"],
      api_params["recipe"]["ingredientLines"],
      api_params["recipe"]["totalNutrients"],
      {
        image: api_params["recipe"]["image"]
      }

    )
  end
end
