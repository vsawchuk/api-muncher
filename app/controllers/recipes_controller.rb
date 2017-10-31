class RecipesController < ApplicationController
  def homepage

  end
  def index
    page = params[:page] || 1
    @recipes = ApiWrapper.list_recipes(params[:search], page)
  end

  def show
    @recipe = ApiWrapper.find_recipe(params[:recipe])
  end
end
