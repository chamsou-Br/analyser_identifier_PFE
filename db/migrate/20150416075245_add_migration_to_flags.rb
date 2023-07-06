class AddMigrationToFlags < ActiveRecord::Migration[4.2]
  def change
    add_column :flags, :migration, :boolean, :default => false
  end
end
