class AddColumnSvgToGraphs < ActiveRecord::Migration[4.2]
  def change
  	add_column :graphs, :svg, :text
  end
end
