class CreatePastilles < ActiveRecord::Migration[4.2]
  def change
    create_table :pastilles do |t|
      t.integer :element_id
      t.integer :role_id
      t.string :responsability

      t.timestamps
    end
  end
end
