class CreateEvaluations < ActiveRecord::Migration[4.2]
  def change
    create_table :evaluations do |t|
      t.references :risk, index: true, foreign_key: true
      t.references :scale, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
