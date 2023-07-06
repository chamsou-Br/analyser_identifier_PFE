class RenameImproverSettingsModels < ActiveRecord::Migration[4.2]
  def change
    remove_column :improver_type_settings, :model
    remove_column :improver_domain_settings, :model
    rename_table :improver_type_settings, :event_type_settings
    rename_table :improver_domain_settings, :event_domain_settings
    rename_table :improver_cause_settings, :event_cause_settings
  end
end
