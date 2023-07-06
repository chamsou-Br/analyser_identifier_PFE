class DropTableSequenceCounter < ActiveRecord::Migration[4.2]
  def up
    drop_table :sequence_counters
  end

  def down
    create_table :sequence_counters do |t|
      t.integer :event_type_order, default: 0
      t.timestamps null: false
    end
  end
end
