class RenameVersionsToEvaluationSystems < ActiveRecord::Migration[5.1]
  def change
    rename_table :versions, :evaluation_systems
  end
end
