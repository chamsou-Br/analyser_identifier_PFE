class CreateGroupgraphs < ActiveRecord::Migration[4.2]
  def change
    create_table :groupgraphs do |t|
      t.integer :customer_id
      t.string :type
      t.integer :level

      t.timestamps
    end
  end
end
