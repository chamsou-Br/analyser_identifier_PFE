class CreateJoinTableRiskAct < ActiveRecord::Migration[5.1]
  def change
    create_join_table :risks, :acts do |t|
      t.index [:risk_id, :act_id], unique: true
      t.index [:act_id, :risk_id]
    end
  end
end
