class AddIndexToReferenceCounter < ActiveRecord::Migration[5.0]
  def change
    remove_index :reference_counters, name: "index_reference_counters_on_customer_id"
    add_index :reference_counters, [:customer_id, :event],
      unique: true,
      name: "index_reference_customer_event"
    add_index :reference_counters, [:customer_id, :act],
      unique: true,
      name: "index_reference_customer_action"
    add_index :reference_counters, [:customer_id, :audit],
      unique: true,
      name: "index_reference_customer_audit"
  end
end
