class CreateLocalisation < ActiveRecord::Migration[4.2]
  def change
    create_table :localisations do |t|
      t.string :label
      t.integer :customer_id
      
      t.timestamps
    end
  end
end
