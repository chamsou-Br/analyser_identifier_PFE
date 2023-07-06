class DropTableRiskLink < ActiveRecord::Migration[5.0]
  def up
    drop_table :risk_links
  end

  def down
    fail ActiveRecord::IrreversibleMigration
  end
end
