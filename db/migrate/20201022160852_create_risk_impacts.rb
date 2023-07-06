class CreateRiskImpacts < ActiveRecord::Migration[5.1]
  def change
    create_table :risk_impacts do |t|
      t.string :title
      t.belongs_to :evaluation_system, foreign_key: true, type: :integer
      t.belongs_to :risk_scale, foreign_key: true

      t.timestamps
    end
  end
end
