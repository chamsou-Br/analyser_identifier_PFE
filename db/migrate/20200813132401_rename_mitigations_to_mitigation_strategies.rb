class RenameMitigationsToMitigationStrategies < ActiveRecord::Migration[5.1]
  def change
    rename_table :mitigations, :mitigation_strategies
  end
end
