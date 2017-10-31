class IndexedRecipe
  STOCK_URL = "https://upload.wikimedia.org/wikipedia/commons/a/ac/No_image_available.svg"
  attr_reader :name, :image_url

  def initialize(name, options = {})
    raise ArgumentError if name == nil || name == ""
    @name = name
    @image_url = options[:image] || STOCK_URL
  end
end
