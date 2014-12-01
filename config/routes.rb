Rails.application.routes.draw do

  #Home
  root 'home#index'

  #Campaigns
  resources :campaigns do
    resources :posts
  end
  
  #Users
  get 'login' => 'user_sessions#new', as: :login
  post 'logout' => 'user_sessions#destroy', as: :logout
  resources :users
  resources :user_sessions, except: [:update, :edit]
  resources :password_resets

  #Oauth
  post "oauth/callback" => "oauths#callback"
  get "oauth/callback" => "oauths#callback"
  get "oauth/:provider" => "oauths#oauth", as: :auth_at_provider

  #Admin Panel
  namespace :admin do
    get 'dashboard' => 'dashboard#index', as: :dashboard
    resources :campaigns
    resources :announcements
    resources :users
  end
end
