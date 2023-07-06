class AddNicknameToCustomerSetting < ActiveRecord::Migration[4.2]
  def change
    add_column :customer_settings, :nickname, :string
  end
end
