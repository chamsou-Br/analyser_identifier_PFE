class DropIdentifications < ActiveRecord::Migration[5.1]
  def up
    begin
      drop_table :identifications
    rescue
      puts "Table already deleted"
    end
  end

  def down
    rescue ActiveRecord::IrreversibleMigration
  end
end
