class Change3ColumnsToRoles < ActiveRecord::Migration[4.2]

  NEW_LIMIT=2300
  OLD_LIMIT=765

  def up
    change_column :roles, :purpose, :string, limit: NEW_LIMIT
    change_column :roles, :mission, :string, limit: NEW_LIMIT
    change_column :roles, :activities, :string, limit: NEW_LIMIT
  end

  def down
    change_column :roles, :purpose, :string, limit: OLD_LIMIT
    change_column :roles, :mission, :string, limit: OLD_LIMIT
    change_column :roles, :activities, :string, limit: OLD_LIMIT
  end
end
