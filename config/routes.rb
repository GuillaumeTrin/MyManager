Rails.application.routes.draw do
  get 'albums/index'
  get 'albums/show'
  get 'albums/new'
  get 'albums/create'
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
