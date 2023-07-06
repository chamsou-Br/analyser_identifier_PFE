class CreateRecordingsUsers < ActiveRecord::Migration[4.2]
  def change
    create_table :recordings_users do |t|
      t.integer :user_id
      t.integer :recording_id
      t.boolean :favorite, :default => false
    end
  end
end
