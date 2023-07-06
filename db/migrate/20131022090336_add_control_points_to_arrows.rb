class AddControlPointsToArrows < ActiveRecord::Migration[4.2]
  def change
  	add_column :arrows, :sx, :decimal, :precision => 9, :scale => 4
  	add_column :arrows, :sy, :decimal, :precision => 9, :scale => 4
  	add_column :arrows, :ex, :decimal, :precision => 9, :scale => 4
  	add_column :arrows, :ey, :decimal, :precision => 9, :scale => 4  	
  end
end
