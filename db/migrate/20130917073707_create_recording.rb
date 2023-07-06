class CreateRecording < ActiveRecord::Migration[4.2]
  def change
    create_table :recordings do |t|
      t.string :title
      t.string :url
      t.string :reference
      t.integer :customer_id

      t.string :stock_tool
      t.string :protect_tool
      t.string :stock_time
      t.string :destroy_tool

      t.timestamps
    end
  end
end
