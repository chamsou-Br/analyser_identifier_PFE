class AddScaleTypeToRiskScales < ActiveRecord::Migration[5.2]
  def change
    add_column :risk_scales, :scale_type, :integer
  end
end
