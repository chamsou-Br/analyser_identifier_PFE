class RenameModuleToAppModuleFormField < ActiveRecord::Migration[4.2]
  def change
    rename_column :form_fields, :module, :app_module
  end
end
