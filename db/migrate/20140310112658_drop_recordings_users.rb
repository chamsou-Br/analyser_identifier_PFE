class DropRecordingsUsers < ActiveRecord::Migration[4.2]
  def up
  	drop_table 'recordings_users'
  end

  def down
  	create_table "recordings_users", :force => true do |t|
      t.integer "user_id"
      t.integer "recording_id"
      t.boolean "favorite",     :default => false
    end
  end
end
