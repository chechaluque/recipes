Rails.application.routes.draw do

  resources :pages
  devise_for :chefs
  resources :recipes do
    resources :comments, only: [:create]
  end
  root 'pages#home'
  resources :ingredients, except: [:destroy]

  mount ActionCable.server => '/cable'
end
