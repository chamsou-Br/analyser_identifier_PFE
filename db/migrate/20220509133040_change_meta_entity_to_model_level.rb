class ChangeMetaEntityToModelLevel < ActiveRecord::Migration[5.2]
  def change
    rename_column :actors, :pyx4_module, :module_level
    rename_column :actors, :meta_entity, :model_level
  end
end
