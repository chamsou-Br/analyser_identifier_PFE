class AddGripColumnsToArrows < ActiveRecord::Migration[4.2]
  def change
    add_column :arrows, :grip_in, :string
    add_column :arrows, :grip_out, :string
  end
end
