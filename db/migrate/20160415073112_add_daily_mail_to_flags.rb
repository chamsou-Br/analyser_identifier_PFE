class AddDailyMailToFlags < ActiveRecord::Migration[4.2]
  def change
    add_column :flags, :daily_mail, :boolean, :default => false
  end
end
