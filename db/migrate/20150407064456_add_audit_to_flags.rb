class AddAuditToFlags < ActiveRecord::Migration[4.2]
  def change
    add_column :flags, :audit, :boolean, :default => false
  end
end
