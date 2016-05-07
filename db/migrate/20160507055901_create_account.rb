class CreateAccount < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string   "name"
      t.string   "crypted_password"
      t.string   "email"
      t.integer  "comments_count",               default: 0, null: false
      t.string   "logo"
      t.string   "openid"
      t.string   "profile_image_url"
      t.string   "provider",          limit: 20
      t.string   "profile_url"

      t.timestamps null: false
    end
  end
end