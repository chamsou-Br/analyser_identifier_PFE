class OptimizeIndicies < ActiveRecord::Migration[4.2]
  def change
    remove_index :form_fields, column: :customer_id
  end
end
