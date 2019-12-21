Rails.application.routes.draw do

  # devise_for :users
  root to: 'toppages#index'
  
  get 'contact', to: 'toppages#contact'
  get "sign_in", to: "users/sessions#new"
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  resources :users, only: [:show, :new, :create , :edit] 
end

