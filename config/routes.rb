Rails.application.routes.draw do

  resources :pages
  devise_for :chefs
  resources :recipes
  root 'pages#home'
  resources :ingredients, except: [:destroy]
end
