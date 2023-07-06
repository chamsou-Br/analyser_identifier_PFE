class AddCustomerIdToUser < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :customer_id, :integer
  end
end
