class AddSparseToTimelineEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :timeline_events, :sparse, :boolean, default: true
  end
end
