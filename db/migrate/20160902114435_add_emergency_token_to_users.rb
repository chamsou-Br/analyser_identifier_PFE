class AddEmergencyTokenToUsers < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :emergency_token, :string
  end
end
