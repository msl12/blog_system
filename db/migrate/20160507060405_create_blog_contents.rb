class CreateBlogContents < ActiveRecord::Migration
  def change
    create_table :blog_contents do |t|
    	t.text "content", limit: 16777215, null: false

    	t.timestamps null: false
    end
  end
end