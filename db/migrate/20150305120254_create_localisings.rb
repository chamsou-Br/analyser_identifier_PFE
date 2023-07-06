class CreateLocalisings < ActiveRecord::Migration[4.2]
  def change
    create_table :localisings do |t|
      t.integer :localisable_id
      t.string :localisable_type
      t.integer :localisation_id
    end
  end
end
