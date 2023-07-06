class CreateTasks < ActiveRecord::Migration[4.2]
  def change
    create_table :tasks do |t|
      t.integer :taskable_id
      t.string :taskable_type
      t.string :action_type
      t.integer :from_id
      t.integer :to_id
      t.timestamp :checked_at

      t.timestamps
    end
  end
end
