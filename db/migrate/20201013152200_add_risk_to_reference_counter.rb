class AddRiskToReferenceCounter < ActiveRecord::Migration[5.1]
  def change
    add_column :reference_counters, :risk, :integer, default: 0,
                                                     null: false
  end
end
