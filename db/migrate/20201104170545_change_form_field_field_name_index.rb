class ChangeFormFieldFieldNameIndex < ActiveRecord::Migration[5.1]
  def change
    # This adds `evaluation_system_id` to the unique index encompassing
    # `field_name`, to allow form fields with the same name to exist for the
    # same customer and app model on different evaluation systems.
    remove_index :form_fields, %i[customer_id app_model field_name]

    add_index :form_fields, %i[customer_id app_model evaluation_system_id field_name],
              unique: true,
              name: "index_form_fields_on_customer_app_model_eval_system_field_name"
  end
end
