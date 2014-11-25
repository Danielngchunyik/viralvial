Rails.application.routes.draw do

  root 'static_pages#index'

  get 'login' => 'user_sessions#new', as: :login

  post 'logout' => 'user_sessions#destroy', as: :logout

  resources :users
  resources :user_sessions, except: [:update, :edit]

  resources :password_resets

  #Oauth
  post "oauth/callback" => "oauths#callback"
  get "oauth/callback" => "oauths#callback"
  get "oauth/:provider" => "oauths#oauth", as: :auth_at_provider

  namespace :admin do
    resources :campaigns
  end
end
