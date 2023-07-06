class RecreateTask < ActiveRecord::Migration[4.2]
  def change
    create_table :tasks do |t|
      t.string :description
      t.string :result
      t.boolean :completed
      t.belongs_to :act
      t.timestamps
    end
  end
end
