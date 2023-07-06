class AlterScaleIndex < ActiveRecord::Migration[4.2]
  def up
    remove_foreign_key :scales, column: :customer_id
    remove_index :scales, [:customer_id,  :active]
    remove_columns :scales, :customer_id
    add_reference :scales, :customer, foreign_key: true
    add_index :scales, [:customer_id, :active]
  end

  def down
    remove_foreign_key :scales, column: :customer_id
    remove_index :scales, [:customer_id,  :active]
    remove_columns :scales, :customer_id
    add_reference :scales, :customer, foreign_key: true
    add_index :scales, [:customer_id, :active], unique: true
  end
end
