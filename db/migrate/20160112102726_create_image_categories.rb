class CreateImageCategories < ActiveRecord::Migration[4.2]
  def change
    create_table :image_categories do |t|
      t.integer :owner_id
      t.string :owner_type
      t.string :label

      t.timestamps null: false
    end
  end
end
