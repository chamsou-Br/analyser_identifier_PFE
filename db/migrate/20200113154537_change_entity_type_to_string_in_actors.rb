class ChangeEntityTypeToStringInActors < ActiveRecord::Migration[5.0]
  def up
    change_column :actors, :entity_type, :string
  end

  def down
    rescue ActiveRecord::IrreversibleMigration
  end

end
