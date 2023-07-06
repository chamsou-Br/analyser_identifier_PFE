class AddFormFieldToRiskImpact < ActiveRecord::Migration[5.1]
  def change
    add_reference :risk_impacts, :form_field, foreign_key: true, type: :integer
  end
end
