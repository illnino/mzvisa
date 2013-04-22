class AddColumnToSpreeUsers < ActiveRecord::Migration
  def change
  	add_column :spree_users, :username, :string
  	add_column :spree_users, :company, :string
  	add_column :spree_users, :phone, :string
  end
end
