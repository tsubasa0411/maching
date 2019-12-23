Rails.application.routes.draw do
  root to: 'toppages#index'
  
  get 'contact', to: 'toppages#contact'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  resources :users, only: [:show, :new, :create, :edit, :update] do
    member do
      get :followers
    end
  end
  

  mount ActionCable.server => '/cable'
  # フォロー機能に必要な記述
end
