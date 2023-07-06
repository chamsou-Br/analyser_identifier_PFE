class AddHiddenColumnToArrows < ActiveRecord::Migration[4.2]
  def change
    add_column :arrows, :hidden, :boolean, :default => false
  end
end
