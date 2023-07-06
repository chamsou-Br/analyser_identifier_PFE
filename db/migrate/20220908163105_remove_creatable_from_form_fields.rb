class RemoveCreatableFromFormFields < ActiveRecord::Migration[5.2]
  def change
    remove_column :form_fields, :creatable, :boolean, default: false
  end
end
