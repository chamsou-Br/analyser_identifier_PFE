class CreateMitigations < ActiveRecord::Migration[4.2]
  def change
    create_table :mitigations do |t|
      t.references :identification, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
