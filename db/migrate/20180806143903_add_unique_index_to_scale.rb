class AddUniqueIndexToScale < ActiveRecord::Migration[4.2]
  def change
    add_index :scales, [:customer_id,  :active], unique: true
    remove_index :scales, :active
    remove_index :scales, :customer_id
  end
end
