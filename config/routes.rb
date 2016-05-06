Rails.application.routes.draw do

  root to: 'home#index'
  match 'login' => 'home#login_get', via: :get, as: 'login'
  match 'login' => 'home#login_post', via: :post, as: 'login_post'
  match 'logout' => 'home#logout', via: :delete, as: 'logout'
  match 'admin/blog/new' => 'admins#new_blog', via: :get
  match 'admin/blog' => 'admins#blog', via: :post
  match "admin/blog/:id/" => 'admins#destroy', via: :delete, as: 'delete_blog'
  match "admin/blog/:id/" => 'admins#edit', via: :put, as: 'blog_edit_put'
  match "admin/blog/:id/edit" => 'admins#edit_blog', via: :get, as: 'blog_edit'
  match 'admin/blog/preview' => 'admins#blog_preview', via: :post, as: 'pre_blog'
  match 'comment/preview' => 'blog#comment_preview', via: :post, as: 'pre_comment'
  match 'blog' => 'blog#index', via: :get, as: ''
  match 'blog/:id' => 'blog#show', via: :get, as: 'blog'
  match 'blog/:id/comments' => 'blog#create_comment', via: :post, as: 'create_comment'
  match 'comment/:id' => 'blog#comment', via: :delete, as: 'delete_comment'
  match 'tag' => 'blog#tag_cloud', via: :get, as: 'tags'
  match 'tag/:name' => 'blog#tag', via: :get, as: 'tag'
  match 'admin/attachment/new' => 'admins#new_attachment', via: :get, as: 'new_attachment'
  match 'admin/attachment' => 'admins#create_attachment', via: :post, as: 'post_attachment'
  match "admin/attachment/:id" => 'admins#attachment', via: :get, as: 'attachment'
  match "admin/attachment/:id" => 'admins#delete_attachment', via: :delete, as: 'delete_attachment'
  match '/qq_callback' => 'home#qq_callback', via: :get, as: 'qq_callback'

end