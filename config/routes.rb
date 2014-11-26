Rails.application.routes.draw do

  #Home
  root 'home#index'

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
    resources :campaigns
    resources :announcements
    resources :users
  end
  
end
