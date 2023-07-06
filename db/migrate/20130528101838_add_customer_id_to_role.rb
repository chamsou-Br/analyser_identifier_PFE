class AddCustomerIdToRole < ActiveRecord::Migration[4.2]
  def change
    add_column :roles, :customer_id, :integer
  end
end
