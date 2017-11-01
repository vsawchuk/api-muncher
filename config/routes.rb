Rails.application.routes.draw do
  root 'recipes#homepage'
  get '/recipes', to: 'recipes#index', as: 'index_recipes'
  get '/recipes/:uri', to: 'recipes#show', as: 'show_recipe'

  get '/auth/:provider/callback', to: 'users#create', as: 'auth_callback'
  get '/logout', to: 'users#logout', as: 'logout'
end
