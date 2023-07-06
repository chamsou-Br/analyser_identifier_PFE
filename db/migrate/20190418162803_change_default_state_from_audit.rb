class ChangeDefaultStateFromAudit < ActiveRecord::Migration[5.0]
  def up
    change_column_default(:audits, :state, nil)
  end

  def down
    change_column_default(:audits, :state, 0)
  end
end
