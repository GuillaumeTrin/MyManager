Rails.application.routes.draw do

  require "sidekiq/web"
    mount Sidekiq::Web => '/sidekiq'

  resources :artists, only: [:show, :index] do
    resources :posts
    resources :albums, only: [:index, :show, :new, :create]
    get 'statartist' , on: :member
  end
  
  resources :posts, only: [:destroy]
  devise_for :users

  authenticated :user do 
    root to: 'dashboards#dashboard', as: :root_authenticate
  end
  root to: 'pages#home'

  get 'oauth2/connect', to: 'facebook#connect'
  get 'oauth2/callback', to: 'facebook#callback'
  # get '/dashboard', to: 'dashboards#dashboard'
  get '/disconnect', to: 'facebook#disconnect'


end
