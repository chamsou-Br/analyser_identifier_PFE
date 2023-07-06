class AddMaxPowerAndSimpleUserToCustomer < ActiveRecord::Migration[4.2]
  def change
    add_column :customers, :max_power_user, :integer
    add_column :customers, :max_simple_user, :integer
  end
end
