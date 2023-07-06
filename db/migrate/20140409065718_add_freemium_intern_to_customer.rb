class AddFreemiumInternToCustomer < ActiveRecord::Migration[4.2]
  def change
    add_column :customers, :freemium, :boolean, :default => true
    add_column :customers, :intern, :boolean, :default => false
    Customer.update_all({ :freemium => true, :intern => false })
  end
end
