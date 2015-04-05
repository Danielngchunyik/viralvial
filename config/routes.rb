Rails.application.routes.draw do

  #Root
  root 'home#traffic_control'

  #Landing
  get "landing", to: "home#landing", as: :landing

  #Campaigns
  resources :campaigns do
    resources :topics do
      resources :posts, except: [:edit]
      resources :user_images
    end
  end

  #Contact
  post 'contact', to: 'contacts#create'
  
  #Users
  get 'warpgate', to: 'user_sessions#new', as: :warpgate
  post 'logout', to: 'user_sessions#destroy', as: :logout
  resources :users
  resources :user_sessions, except: [:update, :edit]
  resources :password_resets

  #Participated Campaigns
  get 'participated', to: 'participated_campaigns#index', as: :participated

  #Oauth
  post "oauth/callback", to: "oauths#callback"
  get "oauth/callback", to: "oauths#callback"
  get "oauth/:provider", to: "oauths#oauth", as: :auth_at_provider
  delete "oauth/:provider", to: "oauths#destroy", as: :delete_oauth

  #Admin Panel
  namespace :admin do
    get 'dashboard', to: 'dashboard#index', as: :dashboard
    resources :options, only: [:edit, :update]
    resources :reward_transactions, only: [:edit, :update]
    resources :featureds
    resources :campaigns do
      resources :topics
    end
    resources :announcements
    resources :users
  end
end
