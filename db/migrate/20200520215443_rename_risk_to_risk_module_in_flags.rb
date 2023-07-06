class RenameRiskToRiskModuleInFlags < ActiveRecord::Migration[5.1]
  def change
    rename_column :flags, :risk, :risk_module
  end
end
