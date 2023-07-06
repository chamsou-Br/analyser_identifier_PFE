class RenamePositionsForRisk < ActiveRecord::Migration[4.2]
  def change
    rename_column :form_fields, :position, :sequence
    rename_column :field_items, :position, :sequence
  end
end
