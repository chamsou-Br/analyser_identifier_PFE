class DropEventsCloser < ActiveRecord::Migration[4.2]
  def up
    drop_table :events_closers
  end

  def down
  end
end
