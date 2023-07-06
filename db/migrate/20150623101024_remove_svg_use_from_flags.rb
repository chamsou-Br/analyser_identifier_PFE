class RemoveSvgUseFromFlags < ActiveRecord::Migration[4.2]
  def change
    remove_column :flags, :svg_use
  end
end
