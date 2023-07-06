class SetDailyMailFlagDefaultToTrue < ActiveRecord::Migration[4.2]
  def change
    change_column :flags, :daily_mail, :boolean, :default => true
    Flag.update_all({:daily_mail => true})
  end
end
