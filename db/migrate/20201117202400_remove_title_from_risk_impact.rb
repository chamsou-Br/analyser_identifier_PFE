class RemoveTitleFromRiskImpact < ActiveRecord::Migration[5.1]
  def change
    remove_column :risk_impacts, :title, :string
  end
end
