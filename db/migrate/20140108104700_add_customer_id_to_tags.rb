class AddCustomerIdToTags < ActiveRecord::Migration[4.2]
  def change
    add_column :tags, :customer_id, :integer
  end
end
