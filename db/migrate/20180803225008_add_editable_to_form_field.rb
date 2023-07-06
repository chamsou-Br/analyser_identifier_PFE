class AddEditableToFormField < ActiveRecord::Migration[4.2]
  def change
    add_column :form_fields, :editable, :boolean, default: true
  end
end
