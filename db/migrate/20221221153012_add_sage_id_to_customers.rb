class AddSageIdToCustomers < ActiveRecord::Migration[5.2]
  def change
    add_column :customers, :sage_id, :string
  end
end
