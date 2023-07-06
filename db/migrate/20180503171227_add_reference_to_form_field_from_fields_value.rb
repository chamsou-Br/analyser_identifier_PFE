class AddReferenceToFormFieldFromFieldsValue < ActiveRecord::Migration[4.2]
  def change
    add_reference :fields_values, :form_field, index: true
  end
end
