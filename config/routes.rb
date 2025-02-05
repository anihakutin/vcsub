Rails.application.routes.draw do
  root 'home#index'
  
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  
  resources :listings
  resources :requests
  resource :profile, only: [:show, :edit, :update]
end 