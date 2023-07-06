class CreateNotifications < ActiveRecord::Migration[4.2]
  def change
    create_table :notifications do |t|
      t.integer :sender_id
      t.integer :receiver_id
      t.text :message
      t.timestamp :checked_at
      t.boolean :favorite, :default => false

      t.timestamps
    end

  end
end
