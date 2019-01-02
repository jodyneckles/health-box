Rails.application.routes.draw do
  resources :recipe_ingredients
  resources :ingredients
  resources :orders
  resources :recipes
  resources :users

  # get "/login", to: 'sessions#new', as: 'login'
  # post "/logout", to: 'sessions#destroy', as: 'logout'

  root 'sessions#new', as: 'login'
  post "/sessions", to: 'sessions#create', as: 'sessions'
  get "/signup", to: 'users#new', as: 'signup'
  root 'sessions#destroy', as: 'logout'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end


# get '/', to: 'user#show', as: 'patient'
