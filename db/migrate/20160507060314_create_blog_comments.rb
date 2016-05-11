class CreateBlogComments < ActiveRecord::Migration
  def change
    create_table :blog_comments do |t|
    	t.integer  "account_id"
	t.integer  "blog_id"
	t.text     "content"

    	t.timestamps null: false
    end
  end
end