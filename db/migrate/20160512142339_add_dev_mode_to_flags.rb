class AddDevModeToFlags < ActiveRecord::Migration[4.2]
  def change
    add_column :flags, :dev_mode, :boolean, :default => false
  end
end
