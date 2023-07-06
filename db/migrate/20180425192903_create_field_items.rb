class CreateFieldItems < ActiveRecord::Migration[4.2]
  def change
    create_table :field_items do |t|
      t.belongs_to :form_field, index: true, foreign_key: true
      t.integer :position, null: false
      t.string :label

      t.timestamps null: false
    end
  end
end
