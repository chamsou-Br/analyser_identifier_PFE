class RenameIndexInFormField < ActiveRecord::Migration[5.1]
  def change
    rename_index :form_fields,
      "index_form_fields_on_customer_id_and_app_model_and_form_section",
      "index_form_fields_on_customer_app_model_form_section"
  end
end
