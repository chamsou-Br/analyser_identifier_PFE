class AddCenteredToArrows < ActiveRecord::Migration[4.2]
  def change
    add_column :arrows, :centered, :boolean, :default => true
  end
end
