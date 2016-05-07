class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
    	t.string   "title",                       null: false
	t.integer  "view_count",      default: 0, null: false
	t.integer  "blog_content_id"
	t.integer  "account_id"
	t.string   "cached_tag_list"
	t.integer  "comments_count",  default: 0, null: false

    	t.timestamps null: false
    end
  end
end