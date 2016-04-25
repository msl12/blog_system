class RemoveUserIdFromBlogContent < ActiveRecord::Migration
  def change
  	remove_column(:blogs, :user_id)
  end
end