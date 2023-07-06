class AddCustomerIdToDirectory < ActiveRecord::Migration[4.2]
  def change
    add_column :directories, :customer_id, :integer
  end
end
