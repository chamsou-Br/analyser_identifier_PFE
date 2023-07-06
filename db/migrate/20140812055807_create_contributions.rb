class CreateContributions < ActiveRecord::Migration[4.2]
  def change
    create_table :contributions do |t|
      t.text :content
      t.integer :contributable_id
      t.string :contributable_type
      t.integer :user_id
      t.timestamps
    end
  end
end
