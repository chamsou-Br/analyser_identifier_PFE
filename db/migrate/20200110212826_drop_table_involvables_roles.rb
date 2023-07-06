class DropTableInvolvablesRoles < ActiveRecord::Migration[5.0]
  def up
    begin
      drop_table :involvables_roles
    rescue
      puts "Table already deleted"
    end
  end

  def down
    rescue ActiveRecord::IrreversibleMigration
  end
end
