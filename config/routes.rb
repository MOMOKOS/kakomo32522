Rails.application.routes.draw do
  devise_for :users
  root to: "comments#index"
  resources :items
  resources :comments
  resources :selects
  resources :results
end
