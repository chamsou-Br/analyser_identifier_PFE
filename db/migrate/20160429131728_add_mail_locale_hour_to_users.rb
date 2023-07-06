class AddMailLocaleHourToUsers < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :mail_locale_hour, :integer, :default => 0
  end
end
