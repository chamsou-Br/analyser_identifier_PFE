class RenameAppModuleToAppModelInFormField < ActiveRecord::Migration[4.2]
  def change
    rename_column :form_fields, :app_module, :app_model
  end
end
