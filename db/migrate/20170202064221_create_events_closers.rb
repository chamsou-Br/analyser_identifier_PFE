class CreateEventsClosers < ActiveRecord::Migration[4.2]
  def change
    create_table :events_closers do |t|
      t.integer :event_id
      t.integer :closer_id
      t.string :comment, limit: 765
      t.boolean :closed, default: false
      t.boolean :historized, default: false

      t.timestamps null: false
    end
  end
end
