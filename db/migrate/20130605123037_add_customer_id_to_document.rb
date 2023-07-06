class AddCustomerIdToDocument < ActiveRecord::Migration[4.2]
  def change
    add_column :documents, :customer_id, :integer
  end
end
