class CreateRisks < ActiveRecord::Migration[4.2]
  def change
    create_table :risks do |t|
      t.belongs_to :customer, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
