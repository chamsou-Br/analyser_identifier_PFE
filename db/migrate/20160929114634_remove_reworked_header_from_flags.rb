class RemoveReworkedHeaderFromFlags < ActiveRecord::Migration[4.2]
  def change
    remove_column :flags, :reworked_header
  end
end
