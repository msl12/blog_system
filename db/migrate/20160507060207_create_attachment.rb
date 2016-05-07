class CreateAttachment < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
    	t.string   "file"
	t.integer  "account_id"
	t.integer  "blog_id"

    	t.timestamps null: false
    end
  end
end