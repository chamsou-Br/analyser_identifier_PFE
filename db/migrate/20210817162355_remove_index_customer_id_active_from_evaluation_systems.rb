class RemoveIndexCustomerIdActiveFromEvaluationSystems < ActiveRecord::Migration[5.2]
  def change
    remove_foreign_key :evaluation_systems, :customers
    remove_index "evaluation_systems", column: [:customer_id], name: "index_evaluation_systems_on_customer_id_and_active" 
  end
end
