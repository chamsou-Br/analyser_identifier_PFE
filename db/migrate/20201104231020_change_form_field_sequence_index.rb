class ChangeFormFieldSequenceIndex < ActiveRecord::Migration[5.1]
  def change
    # This adds `evaluation_system_id` to the unique index encompassing
    # `sequence`, to allow form fields with the same sequence to exist for the
    # same customer and app model on different evaluation systems.
    remove_index :form_fields, name: "unique_composite_index_on_form_fields"

    add_index :form_fields, %i[customer_id app_model
                               form_section evaluation_system_id sequence],
              name: "unique_composite_index_on_form_fields", unique: true
  end
end
