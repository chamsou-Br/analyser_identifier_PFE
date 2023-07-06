class ChangeVersionIdToEvaluationSystemIdInRisk < ActiveRecord::Migration[5.1]
  def change
    rename_column :risks, :version_id, :evaluation_system_id
  end
end
