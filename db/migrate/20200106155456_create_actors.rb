class CreateActors < ActiveRecord::Migration[5.0]
  def change
    create_table :actors do |t|
      t.integer :user_id, null: false
      t.integer :role, null: false
      t.integer :entity_type, null: false
      t.integer :entity_id

      t.timestamps
    end
  end
end
