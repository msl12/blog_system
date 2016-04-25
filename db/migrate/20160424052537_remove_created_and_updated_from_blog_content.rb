class RemoveCreatedAndUpdatedFromBlogContent < ActiveRecord::Migration
  def change
  	remove_column(:blog_contents, :created_at)
  	remove_column(:blog_contents, :updated_at)
  end
end