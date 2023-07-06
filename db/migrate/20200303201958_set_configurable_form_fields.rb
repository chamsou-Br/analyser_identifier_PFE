class SetConfigurableFormFields < ActiveRecord::Migration[5.1]
  def change
    Rake::Task["data_migration:configurable:set_configurable"].invoke
    Rake::Task["data_migration:configurable:set_custom_to_true"].invoke
  end
end
