class CreateEvents < ActiveRecord::Migration[4.2]
  def change
    create_table :events do |t|
      t.string :description, :limit => 765
      t.string :intervention, :limit => 765
      t.datetime :occurrence_date
      t.integer :customer_id
      t.integer :author_id
      t.integer :owner_id
      t.string :state
      t.integer :criticality

      t.timestamps
    end
  end
end
