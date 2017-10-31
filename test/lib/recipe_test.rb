require 'test_helper'

describe Recipe do
  it "requires 4 or 5 arguments" do
    proc{Recipe.new}.must_raise ArgumentError
    proc{Recipe.new("name")}.must_raise ArgumentError
    proc{Recipe.new("name", "link")}.must_raise ArgumentError
    proc{Recipe.new("name", "link", ["ingredients"])}.must_raise ArgumentError
  end

  it "can be created" do
    my_recipe = Recipe.new("name", "link", ["ingredients"], ["dietary info"])
    my_recipe.must_respond_to :name
    my_recipe.must_respond_to :original_link
    my_recipe.must_respond_to :ingredients
    my_recipe.must_respond_to :dietary
    my_recipe.must_respond_to :image_url
    my_recipe.wont_be_nil
    my_recipe.name.must_equal "name"
    my_recipe.original_link.must_equal "link"
    my_recipe.ingredients.must_equal ["ingredients"]
    my_recipe.dietary.must_equal ["dietary info"]
  end
end
