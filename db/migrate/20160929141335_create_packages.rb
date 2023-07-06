class CreatePackages < ActiveRecord::Migration[4.2]
  def change
    create_table :packages do |t|
      t.string :name
      t.text :description
      t.integer :state
      t.boolean :private
      t.references :customer, index: true, foreign_key: true
      t.date :published_at

      t.timestamps null: false
    end
  end
end
