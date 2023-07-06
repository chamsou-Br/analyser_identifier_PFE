class AddPercentFromStartRoArrows < ActiveRecord::Migration[4.2]
  def change
    add_column :arrows, :percent_from_start, :decimal, precision: 9, scale: 4
  end
end
