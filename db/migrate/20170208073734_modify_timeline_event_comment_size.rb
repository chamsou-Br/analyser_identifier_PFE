class ModifyTimelineEventCommentSize < ActiveRecord::Migration[4.2]
  def up
    change_column :timeline_events, :comment, :string, :limit => 12000
  end

  def down
    change_column :timeline_events, :comment, :string, :limit => 255
  end
end
