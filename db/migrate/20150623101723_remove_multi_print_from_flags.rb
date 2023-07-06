class RemoveMultiPrintFromFlags < ActiveRecord::Migration[4.2]
  def change
    remove_column :flags, :multi_print
  end
end
