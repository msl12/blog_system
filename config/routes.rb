Rails.application.routes.draw do

  resources :blogs
  resources :homes

  root to: 'home#index'
  match 'login' => 'home#login', via: :get, as: 'login'

end