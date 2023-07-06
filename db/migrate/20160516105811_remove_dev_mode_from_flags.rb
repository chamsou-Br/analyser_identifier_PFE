class RemoveDevModeFromFlags < ActiveRecord::Migration[4.2]
  def change
    remove_column :flags, :dev_mode
  end
end
