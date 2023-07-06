class AddTimeZoneToCustomersAndUsers < ActiveRecord::Migration[4.2]
  def change
    add_column :customer_settings, :time_zone, :string
    add_column :users, :time_zone, :string

    CustomerSetting.update_all(time_zone: "Paris")
    User.update_all(time_zone: "Paris")
  end
end
