class CreateGraphImages < ActiveRecord::Migration[4.2]
  def change
    create_table :graph_images do |t|
      t.integer :owner_id
      t.string :owner_type
      t.string :title
      t.string :file
      t.integer :image_category_id

      t.timestamps null: false
    end
  end
end