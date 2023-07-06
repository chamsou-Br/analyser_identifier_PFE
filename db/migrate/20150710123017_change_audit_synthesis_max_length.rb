class ChangeAuditSynthesisMaxLength < ActiveRecord::Migration[4.2]
  def up
    change_column :audits, :synthesis, :text, :limit => 65535
  end

  def down
    change_column :audits, :synthesis, :string, :limit => 1530
  end
end
