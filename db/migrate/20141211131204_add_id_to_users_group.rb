class AddIdToUsersGroup < ActiveRecord::Migration[4.2]
  def change
    add_column :users_groups, :id, :primary_key
  end
end
