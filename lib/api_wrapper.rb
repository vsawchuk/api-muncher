require 'httparty'
require 'awesome_print'

class ApiWrapper
  BASE_URL = "https://api.edamam.com/"
  APP_ID = ENV["EDAMAM_APPLICATION_ID"]
  APP_KEY = ENV["EDAMAM_APPLIATION_KEY"]

  def self.list_recipes(search, page=1)
    url = BASE_URL + "/search?q=#{search}&app_id=#{APP_ID}&app_key=#{APP_KEY}&from=#{page}"
    data = HTTParty.get(url).parsed_response
    recipe_list = []
    if data["hits"]
      data["hits"].each do |recipe_data|
        recipe_list << indexed_recipe(recipe_data)
      end
    end
    return recipe_list
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
end
