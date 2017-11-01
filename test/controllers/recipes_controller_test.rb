require "test_helper"

describe RecipesController do
  describe "homepage" do
    it "successfully gets the homepage" do
      get root_path
      must_respond_with :success
    end
  end

  describe "index" do
    it "succeeds with a valid search" do
      VCR.use_cassette("recipes_controller_index") do
        get index_recipes_path("chicken")
        must_respond_with :success
      end
    end

    it "succeeds with an invalid search" do
      VCR.use_cassette("recipes_controller_index") do
        get index_recipes_path("")
        must_respond_with :success
      end
    end

    it "succeeds with an invalid search/page" do
      VCR.use_cassette("recipes_controller_index") do
        get index_recipes_path("", -1)
        must_respond_with :success
      end
    end
  end

  describe "show" do
    it "succeeds with a valid search" do
      VCR.use_cassette("recipes_controller_show") do
        valid_uri = "http://wwwdotreplaceedamamdotreplacecom/ontologies/edamamdotreplaceowl%23recipe_b79327d05b8e5b838ad6cfd9576b30b6"
        get show_recipe_path(valid_uri)
        must_respond_with :success
      end
    end

    it "redirects with an invalid search" do
      VCR.use_cassette("recipes_controller_show") do
        get show_recipe_path(" ")
        must_respond_with :redirect
        flash[:status].must_equal :error
        flash[:result].must_equal "Please try another recipe"
      end
    end
  end
end
