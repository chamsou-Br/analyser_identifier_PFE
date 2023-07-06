class CreateScales < ActiveRecord::Migration[4.2]
  def change
    create_table :scales do |t|
      t.references :customer, index: true, foreign_key: true
      t.boolean :active, index: true

      t.timestamps null: false
    end
  end
end
