class AddCustomerIdToGraph < ActiveRecord::Migration[4.2]
  def change
    add_column :graphs, :customer_id, :integer
  end
end
