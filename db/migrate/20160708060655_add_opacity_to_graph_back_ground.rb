class AddOpacityToGraphBackGround < ActiveRecord::Migration[4.2]
  def up
    add_column :graph_backgrounds, :opacity, :integer, default: 100
    GraphBackground.all.each{|g| g.update(opacity: 100)}
  end

  def down
    remove_column :graph_backgrounds, :opacity
  end
end
