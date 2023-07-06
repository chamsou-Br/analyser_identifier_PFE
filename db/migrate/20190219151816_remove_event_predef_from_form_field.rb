class RemoveEventPredefFromFormField < ActiveRecord::Migration[5.0]
  def change
    remove_column :form_fields, :event_predef, :integer
  end
end
