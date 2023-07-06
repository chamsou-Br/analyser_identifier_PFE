class DeleteSatisfactionFromAudit < ActiveRecord::Migration[5.1]
  def change
    remove_column :audits, :satisfaction, :integer
  end
end
