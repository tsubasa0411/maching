Rails.application.routes.draw do

  # devise_for :users
  root to: 'toppages#index'
  
  get 'contact', to: 'toppages#contact'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  resources :users, only: [:show, :new, :create , :edit] do

  end
end

