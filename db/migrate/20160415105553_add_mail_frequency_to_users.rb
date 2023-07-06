class AddMailFrequencyToUsers < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :mail_frequency, :string, :default => 'real_time'
  end
end
