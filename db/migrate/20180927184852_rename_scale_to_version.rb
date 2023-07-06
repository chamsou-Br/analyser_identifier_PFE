class RenameScaleToVersion < ActiveRecord::Migration[4.2]
  def change
    rename_table :scales, :versions
    rename_column :evaluations, :scale_id, :version_id
    rename_column :form_fields, :scale_id, :version_id
  end
end
