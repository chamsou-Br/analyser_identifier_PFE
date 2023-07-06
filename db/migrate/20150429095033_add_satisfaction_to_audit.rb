class AddSatisfactionToAudit < ActiveRecord::Migration[4.2]
  def change
    add_column :audits, :satisfaction, :integer, default: nil
  end
end
