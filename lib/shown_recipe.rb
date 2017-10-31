class ShownRecipe
  STOCK_URL = "https://upload.wikimedia.org/wikipedia/commons/a/ac/No_image_available.svg"
  attr_reader :name, :original_link, :ingredients, :dietary, :image_url

  def initialize(name, original_link, ingredients, dietary, options = {})
    raise ArgumentError if name == nil || name == ""
    @name = name
    @original_link = original_link
    @ingredients = ingredients
    @dietary = dietary
    @image_url = options[:image] || STOCK_URL
  end
end
