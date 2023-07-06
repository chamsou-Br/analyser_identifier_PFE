class AddCustomerToActor < ActiveRecord::Migration[5.0]
  def change
    add_reference :actors, :customer, foreign_key: true
  end
end
