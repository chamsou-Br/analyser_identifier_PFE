class ChangeAuditSynthesisMaxLenght < ActiveRecord::Migration[4.2]
  def change
    change_column :audits, :synthesis, :string, :limit => 1530
  end
end