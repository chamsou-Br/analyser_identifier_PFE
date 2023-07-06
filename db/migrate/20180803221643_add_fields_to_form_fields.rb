class AddFieldsToFormFields < ActiveRecord::Migration[4.2]
  def change
    add_reference :form_fields, :scale, index: true, foreign_key: true
    add_column :form_fields, :group, :integer
  end
end
