Rails.application.routes.draw do

  resources :blogs
  resources :homes

  root to: 'home#index'
  match 'login' => 'home#login_get', via: :get, as: 'login'
  match 'login' => 'home#login_post', via: :post, as: 'login_post'
  match 'logout' => 'home#logout', via: :delete, as: 'logout'
  match 'admin/blog/new' => 'admin#new_blog', via: :get
  match 'admin/blog' => 'admin#blog', via: :post

end