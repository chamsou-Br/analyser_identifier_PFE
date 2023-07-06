class ModifySvgColumnSize < ActiveRecord::Migration[4.2]
  def up
  	change_column :graphs, :svg, :text, :limit => 1000000
  end

  def down
  	change_column :graphs, :svg, :text, :limit => 65535
  end
end
