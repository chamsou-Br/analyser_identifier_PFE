class AddApprovedReadToCustomerSettings < ActiveRecord::Migration[4.2]
  def change
    add_column :customer_settings, :approved_read, :integer, default: 0
  end
end
