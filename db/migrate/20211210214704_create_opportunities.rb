class CreateOpportunities < ActiveRecord::Migration[5.2]
  def change
    create_table :opportunities do |t|
      t.references :customer, foreign_key: true, type: :integer
      t.integer :state
      t.string :internal_reference

      t.timestamps
    end
  end
end
