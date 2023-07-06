class ChangeAuditsState < ActiveRecord::Migration[4.2]
  def change
    remove_column :audits, :state
    add_column :audits, :state, :integer, default: 0
  end
end
