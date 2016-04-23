class AddBlogContentIdToBlog < ActiveRecord::Migration
  def change
  	add_column(:blogs, :blog_content_id, :integer)
  end
end