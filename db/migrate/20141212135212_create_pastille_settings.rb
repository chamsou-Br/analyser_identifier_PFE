class CreatePastilleSettings < ActiveRecord::Migration[4.2]
  def change
    create_table :pastille_settings do |t|
      t.string :color
      t.string :desc_en
      t.string :desc_fr
      t.string :desc_es
      t.string :desc_nl
      t.string :desc_de
      t.string :label, limit: 1
      t.boolean :activated
      t.integer :customer_setting_id

      t.timestamps
    end
  end
end
