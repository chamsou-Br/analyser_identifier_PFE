class CreateReadConfirmations < ActiveRecord::Migration[4.2]
  def change
    create_table :read_confirmations do |t|
      t.string :process_type
      t.integer :process_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
