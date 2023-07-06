class AddMultiPrintToFlags < ActiveRecord::Migration[4.2]
  def change
    add_column :flags, :multi_print, :boolean, :default => false
    Flag.update_all({:multi_print => false})
  end
end
