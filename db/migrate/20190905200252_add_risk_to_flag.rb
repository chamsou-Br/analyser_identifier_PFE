class AddRiskToFlag < ActiveRecord::Migration[5.0]
  def change
    add_column :flags, :risk, :boolean, default: false
  end
end
