class AddDeactivatedAndDeactivatedAtToCustomers < ActiveRecord::Migration[4.2]
  def change
    add_column :customers, :deactivated, :boolean, :default => false
    add_column :customers, :deactivated_at, :datetime
  end
end
