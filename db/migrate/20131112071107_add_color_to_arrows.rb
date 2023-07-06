class AddColorToArrows < ActiveRecord::Migration[4.2]
  def change
    add_column :arrows, :color, :string
  end
end
