class AddProfileImageUrlToAccount < ActiveRecord::Migration
  def change
  	add_column(:accounts, :profile_image_url, :string)
  end
end