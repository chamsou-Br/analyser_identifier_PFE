class AddPatternToGraphBackgrounds < ActiveRecord::Migration[4.2]
  def change
    add_column :graph_backgrounds, :pattern, :string
  end
end
