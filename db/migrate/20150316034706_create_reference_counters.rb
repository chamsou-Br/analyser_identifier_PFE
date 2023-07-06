class CreateReferenceCounters < ActiveRecord::Migration[4.2]
  def change
    create_table :reference_counters do |t|
      t.integer :event, default: 0
      t.integer :act, default: 0
      t.integer :customer_id
    end
  end
end
