class CreateDirectories < ActiveRecord::Migration[4.2]
  def change
    create_table :directories do |t|
      t.string :name
      t.integer :parent_id
      t.integer :lft
      t.integer :rgt

      t.timestamps
    end
  end
end
