class CreateNewNotifications < ActiveRecord::Migration[4.2]
  def change
    create_table :new_notifications do |t|
      t.integer :category
      t.integer :from_id
      t.integer :to_id
      t.integer :entity_id
      t.string :entity_type

      t.timestamps
    end
  end
end
