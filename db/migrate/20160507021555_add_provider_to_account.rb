class AddProviderToAccount < ActiveRecord::Migration
  def change
  	add_column(:accounts, :provider, :string, :limit => 20)
  end
end