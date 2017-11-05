require 'httparty'

class ApiWrapper
  BASE_URL = "https://api.edamam.com/"
  APP_ID = ENV["EDAMAM_APPLICATION_ID"]
  APP_KEY = ENV["EDAMAM_APPLICATION_KEY"]

  def self.list_recipes(search, page=1, id=APP_ID, key=APP_KEY)
    url = BASE_URL + "search?q=#{search}&app_id=#{id}&app_key=#{key}&from=#{(page - 1) * 10}"
    data = HTTParty.get(url).parsed_response
    recipe_list = []
    if data["hits"]
      data["hits"].each do |recipe_data|
        recipe_list << listed_recipe(recipe_data)
      end
    end
    count = data["count"] || 0
    return {recipes: recipe_list, count: count}
  end

  def self.find_recipe(uri, id=APP_ID, key=APP_KEY)
    uri = uri.gsub('dotreplace', '.')
    url = BASE_URL + "search?r=#{(uri)}&app_id=#{id}&app_key=#{key}"
    begin
      data = HTTParty.get(url).parsed_response
    rescue
      data = []
    end
    if data.first
      return shown_recipe(data.first) if data.first["uri"]
    end
    return nil
  end

  private

  def self.listed_recipe(api_params)
    return Recipe.new(
      api_params["recipe"]["uri"],
      api_params["recipe"]["label"],
      api_params["recipe"]["url"],
      api_params["recipe"]["ingredientLines"],
      api_params["recipe"]["totalNutrients"],
      api_params["recipe"]["source"],
      {
        image: api_params["recipe"]["image"]
      }

    )
  end

  def self.shown_recipe(api_params)
    return Recipe.new(
      api_params["uri"],
      api_params["label"],
      api_params["url"],
      api_params["ingredientLines"],
      api_params["totalNutrients"],
      api_params["source"],
      {
        image: api_params["image"]
      }

    )
  end
end
