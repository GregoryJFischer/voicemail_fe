class RemoveAddressColumnsFromUsersTable < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :street_address_1
    remove_column :users, :street_address_2
    remove_column :users, :city
    remove_column :users, :state
    remove_column :users, :zip_code
  end
end
