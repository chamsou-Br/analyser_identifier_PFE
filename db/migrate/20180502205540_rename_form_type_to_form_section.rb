class RenameFormTypeToFormSection < ActiveRecord::Migration[4.2]
  def change
    rename_column :form_fields, :form_type, :form_section
  end
end
