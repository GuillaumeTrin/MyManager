Rails.application.routes.draw do
  resources :artists, only: [:show, :index] do
    resources :posts
    resources :albums, only: [:index, :show, :new, :create]
  end
  devise_for :users
  root to: 'pages#home'

end
