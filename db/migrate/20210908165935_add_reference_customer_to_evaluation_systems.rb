class AddReferenceCustomerToEvaluationSystems < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key :evaluation_systems, :customers, column: :customer_id
  end
end
