class ChangeRoleToStringInActors < ActiveRecord::Migration[5.1]
  def up
    change_column :actors, :role, :string
  end

  def down
    rescue ActiveRecord::IrreversibleMigration
  end
end
