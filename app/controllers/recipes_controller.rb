class RecipesController < ApplicationController
  def homepage
  end

  def index
    @search = params[:search] || ""
    @page = (params[:page].to_i > 0) ? params[:page].to_i : 1
    recipe_hash = ApiWrapper.list_recipes(@search, @page)
    @recipes = recipe_hash[:recipes]
    @count = (recipe_hash[:count] > 100) ? 100 : recipe_hash[:count]
    set_pages(@page, @count)
  end

  def show
    @recipe = ApiWrapper.find_recipe(params[:recipe])
  end

  private

  def set_pages(page, count)
    @last_page = (count / 10.0).ceil
    if count <= 50
      @min_page = 1
      @max_page = @last_page
      return
    end

    if page <= 3
      @min_page = 1
      @max_page = 5
      return
    end

    if (@last_page - page) < 3
      @min_page = @last_page - 4
      @max_page = @last_page
      return
    end

    @min_page = page - 2
    @max_page = page + 2
    return
  end
end
