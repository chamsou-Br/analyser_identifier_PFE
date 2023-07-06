class ChangeVersionIdToEvaluationSystemIdInFormField < ActiveRecord::Migration[5.1]
  def change
    rename_column :form_fields, :version_id, :evaluation_system_id
  end
end
