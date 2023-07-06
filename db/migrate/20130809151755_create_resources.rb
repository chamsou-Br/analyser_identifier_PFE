class CreateResources < ActiveRecord::Migration[4.2]
  def change
    create_table :resources do |t|
      t.string :title
      t.string :url
      t.string :reference
      t.integer :customer_id

      t.timestamps
    end
  end
end
