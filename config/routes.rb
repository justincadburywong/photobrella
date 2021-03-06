Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users
  resources :pictures, only: [:index, :create, :update, :destroy]

  root 'pictures#index'
end
