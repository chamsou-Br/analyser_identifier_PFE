class ChangeColumnDefaultInActionPlan < ActiveRecord::Migration[5.1]
  def change
    change_column :action_plans, :plan_frozen, :boolean, default: false, null: false
  end
end
