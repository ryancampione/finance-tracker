Rails.application.routes.draw do
    
  devise_for :users, :controllers => {:registrations => "user/registrations"}
  root 'welcome#index'
  
  get 'my_portfolio', to: "users#my_portfolio"
  get 'my_friends', to: "users#my_friends"
  get 'search_stocks', to: "stocks#search"
  get 'search_friends', to: "users#search"
  post 'add_friend', to: "users#add_friend"
 
  resources :users, only: [:show]
  resources :friendships
  resources :user_stocks, only: [:create, :destroy]
end
