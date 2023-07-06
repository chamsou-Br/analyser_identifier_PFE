class RemoveCustomerIdFromActors < ActiveRecord::Migration[5.1]
  def change
    remove_reference :actors, :customer, index: true, foreign_key: true
  end
end
