class AddReservedToCustomers < ActiveRecord::Migration[4.2]
  def change
    add_column :customers, :reserved, :boolean, :default => false
  end
end
