class AddInternalPuCountToCustomers < ActiveRecord::Migration[5.2]
  def change
    add_column :customers, :internal_pu_count, :integer
  end
end
