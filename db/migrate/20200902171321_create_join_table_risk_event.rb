class CreateJoinTableRiskEvent < ActiveRecord::Migration[5.1]
  def change
    create_join_table :risks, :events do |t|
      t.index [:risk_id, :event_id], unique: true
      t.index [:event_id, :risk_id]
    end
  end
end
