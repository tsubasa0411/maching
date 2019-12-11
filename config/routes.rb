Rails.application.routes.draw do
  


 
  # devise_for :users
  root 'tweets#index'  #ツイート一覧画面
  get   'tweets/new'  =>  'tweets#new'
  post  'tweets'      =>  'tweets#create'   
end

