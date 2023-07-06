class RenameCustomizableToFieldable < ActiveRecord::Migration[4.2]
  def change
    rename_column :fields_values, :customizable_id, :fieldable_id
    rename_column :fields_values, :customizable_type, :fieldable_type
  end
end
