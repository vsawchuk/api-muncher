class Recipe
  STOCK_URL = "https://upload.wikimedia.org/wikipedia/commons/a/ac/No_image_available.svg"
  attr_reader :uri, :name, :original_link, :ingredients, :dietary, :image_url

  def initialize(uri, name, original_link, ingredients, dietary, options = {})
    raise ArgumentError if name == nil || name == ""
    @uri = URI.encode(uri)
    @name = name
    @original_link = original_link
    @ingredients = ingredients
    @dietary = dietary
    @image_url = options[:image] || STOCK_URL
  end
end
