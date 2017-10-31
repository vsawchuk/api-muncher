Rails.application.routes.draw do
  root 'recipes#homepage'
  get '/recipes', to: 'recipes#index', as: 'index_recipes'
  get '/recipes/:recipe', to: 'recipes#show', as: 'show_recipe'
end
