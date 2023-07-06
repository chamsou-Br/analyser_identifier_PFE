class AddEmergencySentAtToUsers < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :emergency_sent_at, :datetime
  end
end
