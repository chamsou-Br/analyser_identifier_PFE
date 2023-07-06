class AddIndexToFormFields < ActiveRecord::Migration[5.0]
  def change
    change_column_null :form_fields, :field_name, false
    add_index :form_fields, %i[customer_id app_model field_name], unique: true
  end
end
