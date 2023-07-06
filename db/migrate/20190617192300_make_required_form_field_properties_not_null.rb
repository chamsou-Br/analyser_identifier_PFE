class MakeRequiredFormFieldPropertiesNotNull < ActiveRecord::Migration[5.0]
  def change
    change_column_null :form_fields, :app_model, false
    change_column_null :form_fields, :field_type, false
    change_column_null :form_fields, :form_section, false
  end
end
