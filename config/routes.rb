Rails.application.routes.draw do
  root 'home#index'
  
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }, skip: [:registrations, :passwords]
  
  resources :listings do
    member do
      patch :mark_as_sold
    end
  end
  
  resources :requests do
    member do
      patch :mark_as_fulfilled
    end
  end
  
  resource :profile, only: [:show, :edit, :update]
end 