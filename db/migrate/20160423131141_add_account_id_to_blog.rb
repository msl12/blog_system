class AddAccountIdToBlog < ActiveRecord::Migration
  def change
  	add_column(:blogs, :account_id, :integer)
  end
end