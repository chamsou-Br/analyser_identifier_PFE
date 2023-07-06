class AddCustomToPastilleSettings < ActiveRecord::Migration[5.1]
  def up
    add_column :pastille_settings, :custom, :boolean, default: true

    Rake::Task["data_migration:pastille_setting:custom_to_false_for_raci"].invoke
  end

  def down
    remove_column :pastille_settings, :custom, :boolean
  end

end
