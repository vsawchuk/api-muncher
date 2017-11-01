require 'test_helper'

describe ApiWrapper do
  describe 'list_recipes' do
    it 'will return a hash with a valid id/key and search term' do
      VCR.use_cassette("api_wrapper_list_recipes") do
        recipe_hash = ApiWrapper.list_recipes("chicken")
        recipe_hash[:recipes].must_be_instance_of Array
        recipe_hash[:recipes].length.must_be :>, 0
        recipe_hash[:count].must_be_instance_of Integer
        recipe_hash[:count].must_be :>, 0
      end
    end

    it 'will return a hash with a valid id/key and invalid search term' do
      VCR.use_cassette("api_wrapper_list_recipes") do
        recipe_hash = ApiWrapper.list_recipes("")
        recipe_hash[:recipes].must_be_instance_of Array
        recipe_hash[:recipes].must_equal []
        recipe_hash[:count].must_be_instance_of Integer
        recipe_hash[:count].must_equal 0
      end
    end

    it "won't get a list of recipes for an invalid id/key" do
      VCR.use_cassette("api_wrapper_list_recipes") do
        recipe_hash = ApiWrapper.list_recipes("chicken", 1, "bogus", "bogus")
        recipe_hash[:recipes].must_be_instance_of Array
        recipe_hash[:recipes].must_equal []
        recipe_hash[:count].must_be_instance_of Integer
        recipe_hash[:count].must_equal 0
      end
    end
  end

  describe 'find_recipe' do
    it 'will return a recipe with a valid id/key and search term' do
      VCR.use_cassette("api_wrapper_find_recipe") do
        valid_uri = "http://www.edamam.com/ontologies/edamam.owl%23recipe_b79327d05b8e5b838ad6cfd9576b30b6"
        recipe = ApiWrapper.find_recipe(valid_uri)
        recipe.wont_be_nil
        recipe.must_be_instance_of Recipe
        recipe.name.must_equal "Chicken Vesuvio"
      end
    end

    it 'will return nil with a valid id/key and invalid search term' do
      VCR.use_cassette("api_wrapper_find_recipe") do
        recipe = ApiWrapper.find_recipe("BOGUS")
        recipe.must_equal nil
      end
    end

    it "will return nil for an invalid id/key" do
      VCR.use_cassette("api_wrapper_find_recipe") do
        recipe = ApiWrapper.find_recipe("Chicken Vesuvio", "bogus", "bogus")
        recipe.must_equal nil
      end
    end
  end
end
