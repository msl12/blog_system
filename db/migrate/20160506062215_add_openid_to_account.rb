class AddOpenidToAccount < ActiveRecord::Migration
  def change
  	add_column(:accounts, :openid, :string)
  end
end