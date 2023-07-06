class AddSparseToTimelineActs < ActiveRecord::Migration[5.0]
  def change
    add_column :timeline_acts, :sparse, :boolean, default: true
  end
end
