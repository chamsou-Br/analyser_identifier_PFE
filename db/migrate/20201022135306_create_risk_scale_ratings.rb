class CreateRiskScaleRatings < ActiveRecord::Migration[5.1]
  def change
    create_table :risk_scale_ratings do |t|
      t.string :color
      t.integer :value
      t.string :i18n_key
      t.string :label
      t.string :description
      t.belongs_to :risk_scale, foreign_key: true

      t.timestamps
    end
  end
end
