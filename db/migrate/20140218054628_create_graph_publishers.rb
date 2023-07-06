class CreateGraphPublishers < ActiveRecord::Migration[4.2]
  def change
    create_table :graph_publishers do |t|
      t.integer :graph_id
      t.integer :publisher_id
      t.boolean :published
      t.datetime :publish_date

      t.timestamps
    end
  end
end
