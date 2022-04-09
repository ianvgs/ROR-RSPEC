Rails.application.routes.draw do

  resources :weapons, only: [:index, :destroy, :show, :create]

  resources :users, only: [:index, :create]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  #teste de requests em api
  resources :enemies, only: [:update, :destroy]
end
