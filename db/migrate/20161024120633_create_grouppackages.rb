class CreateGrouppackages < ActiveRecord::Migration[4.2]
  def change
    create_table :grouppackages do |t|
      t.integer :customer_id

      t.timestamps
    end
  end
end
