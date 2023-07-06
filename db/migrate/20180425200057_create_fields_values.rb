class CreateFieldsValues < ActiveRecord::Migration[4.2]
  def change
    create_table :fields_values do |t|
      t.belongs_to :customizable, polymorphic: true
      t.text :value
      t.belongs_to :field_item, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
