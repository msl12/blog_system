class AddCommentsCountToAccountAndBlog < ActiveRecord::Migration
  def change
  	add_column(:accounts, :comments_count, :integer, default: 0, null: false)
  	add_column(:blogs, :comments_count, :integer, default: 0, null: false)
  end
end