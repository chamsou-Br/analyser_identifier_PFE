class CreateJoinTableActActionPlan < ActiveRecord::Migration[5.1]
  def change
    create_join_table :acts, :action_plans do |t|
      t.index [:act_id, :action_plan_id], unique: true
      t.index [:action_plan_id, :act_id]
    end
  end
end
