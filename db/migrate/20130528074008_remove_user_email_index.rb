class RemoveUserEmailIndex < ActiveRecord::Migration[4.2]
  def up
    remove_index :users, :email
  end

  def down
    add_index :users, :email
  end
end
