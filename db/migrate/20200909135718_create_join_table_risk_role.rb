class CreateJoinTableRiskRole < ActiveRecord::Migration[5.1]
  def change
    create_join_table :risks, :roles do |t|
      t.index [:risk_id, :role_id], unique: true
      t.index [:role_id, :risk_id]
    end
  end
end
