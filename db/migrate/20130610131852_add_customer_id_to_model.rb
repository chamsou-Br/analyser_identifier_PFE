class AddCustomerIdToModel < ActiveRecord::Migration[4.2]
  def change
    add_column :models, :customer_id, :integer
  end
end
