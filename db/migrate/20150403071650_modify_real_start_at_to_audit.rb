class ModifyRealStartAtToAudit < ActiveRecord::Migration[4.2]
  def change
    add_column :audits, :real_started_at, :date
    add_column :audits, :completed_at, :date
  end
end
