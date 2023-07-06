class AddLinkableTypeToFormFields < ActiveRecord::Migration[4.2]
  def change
    add_column :form_fields, :linkable_type, :string
  end
end
