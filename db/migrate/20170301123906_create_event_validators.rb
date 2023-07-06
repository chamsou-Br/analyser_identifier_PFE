class CreateEventValidators < ActiveRecord::Migration[4.2]
  def change
    create_table :event_validators do |t|
      t.integer :validator_id
      t.integer :event_id
      t.timestamps null: false
      t.string :response
      t.datetime :response_at
      t.string :comment
    end
  end
end
