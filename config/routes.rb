Rails.application.routes.draw do
  root 'recipes#list'
  get '/recipes', to: 'recipes#list', as: 'list_recipes'
end
