class AddProfileUrlToAccount < ActiveRecord::Migration
  def change
  	add_column(:accounts, :profile_url, :string)
  end
end