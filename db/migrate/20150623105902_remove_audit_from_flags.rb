class RemoveAuditFromFlags < ActiveRecord::Migration[4.2]
  def change
    remove_column :flags, :audit
  end
end
