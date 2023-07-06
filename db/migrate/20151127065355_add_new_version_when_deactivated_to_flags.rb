class AddNewVersionWhenDeactivatedToFlags < ActiveRecord::Migration[4.2]
  def change
    add_column :flags, :new_version, :boolean, :default => false
  end
end
