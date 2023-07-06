class AddTryToCustomer < ActiveRecord::Migration[4.2]
  def change
    add_column :customers, :try, :boolean
  end
end
