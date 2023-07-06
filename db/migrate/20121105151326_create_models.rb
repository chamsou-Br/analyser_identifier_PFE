class CreateModels < ActiveRecord::Migration[4.2]
  def change
    create_table :models do |t|
      t.string :name
      t.string :type
      t.integer :level
      t.boolean :landscape, :default => false

      t.timestamps
    end
  end
end
