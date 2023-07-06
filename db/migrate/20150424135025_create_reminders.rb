class CreateReminders < ActiveRecord::Migration[4.2]
  def change
    create_table :reminders do |t|
      t.integer :remindable_id
      t.string :remindable_type
      t.string :job_id
      t.string :reminder_type
      t.date :occurs_at
      t.date :reminds_at
      t.integer :from_id
      t.integer :to_id

      t.timestamps null: false
    end
  end
end
