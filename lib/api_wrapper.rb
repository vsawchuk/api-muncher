require 'httparty'
require 'awesome_print'

class ApiWrapper
  BASE_URL = "https://api.edamam.com/"
  APP_ID = ENV["EDAMAM_APPLICATION_ID"]
  APP_KEY = ENV["EDAMAM_APPLICATION_KEY"]

  def self.list_recipes(search, page=1, id=APP_ID, key=APP_KEY)
    url = BASE_URL + "/search?q=#{search}&app_id=#{id}&app_key=#{key}&from=#{(page - 1) * 10}"
    data = HTTParty.get(url).parsed_response
    recipe_list = []
    if data["hits"]
      data["hits"].each do |recipe_data|
        recipe_list << new_recipe(recipe_data)
      end
    end
    count = data["count"] || 0
    return {recipes: recipe_list, count: count}
  end

  def self.find_recipe(recipe, id=APP_ID, key=APP_KEY)
    url = BASE_URL + "/search?q=#{recipe}&app_id=#{id}&app_key=#{key}"
    data = HTTParty.get(url).parsed_response
    if data["hits"]
      return new_recipe(data["hits"].first) if data["hits"].length > 0
    end
    return nil
  end

  private

  def self.new_recipe(api_params)
    return Recipe.new(
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
