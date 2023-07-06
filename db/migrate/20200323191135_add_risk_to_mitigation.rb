class AddRiskToMitigation < ActiveRecord::Migration[5.1]
  def change
    add_reference :mitigations, :risk, type: :integer, foreign_key: true, index: true
  end
end
