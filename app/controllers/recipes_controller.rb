class RecipesController < ApplicationController
  def list
    page = params[:page] || 1
    @recipes = ApiWrapper.list_recipes(params[:search], page)
  end
end
