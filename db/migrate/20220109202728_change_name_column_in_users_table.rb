class ChangeNameColumnInUsersTable < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :first_name
    remove_column :users, :last_name
  end

  def change
    add_column :users, :name, :string
  end
end
