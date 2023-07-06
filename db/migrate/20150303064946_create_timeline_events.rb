class CreateTimelineEvents < ActiveRecord::Migration[4.2]
  def change
    create_table :timeline_events do |t|
      t.integer :author_id
      t.integer :event_id
      t.text :object
      t.string :comment
      t.string :action

      t.timestamps
    end
  end
end
