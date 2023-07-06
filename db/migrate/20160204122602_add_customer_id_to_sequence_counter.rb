class AddCustomerIdToSequenceCounter < ActiveRecord::Migration[4.2]
  def change
    add_column :sequence_counters, :customer_id, :integer
  end
end
