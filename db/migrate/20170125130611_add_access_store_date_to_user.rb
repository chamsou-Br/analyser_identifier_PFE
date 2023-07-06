class AddAccessStoreDateToUser < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :last_access_to_store, :timestamp, :default => DateTime.new(1970, 1, 1, 0, 0, 1)
    add_column :users, :current_access_to_store, :timestamp, :default => DateTime.new(1970, 1, 1, 0, 0, 1)
  end
end
