class CreateIdentification < ActiveRecord::Migration[4.2]
  def change
    create_table :identifications do |t|
      t.references :risk, index: true, foreign_key: true
    end
  end
end
