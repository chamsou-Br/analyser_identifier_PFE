class CreateActsValidators < ActiveRecord::Migration[4.2]
  def change
    create_table :acts_validators do |t|
      t.integer :act_id
      t.integer :validator_id
      t.integer :response
      t.datetime :response_at

      t.timestamps
    end
  end
end
