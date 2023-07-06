class SetMultiPrintFlagTrueByDefault < ActiveRecord::Migration[4.2]
  def change
    change_column :flags, :multi_print, :boolean, :default => true
    Flag.update_all({:multi_print => true})
  end
end
