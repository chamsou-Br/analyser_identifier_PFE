class AddOwnerToUsers < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :owner, :boolean, :default => false
  end
end
