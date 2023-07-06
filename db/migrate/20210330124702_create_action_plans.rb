class CreateActionPlans < ActiveRecord::Migration[5.1]
  def change
    create_table :action_plans do |t|
      t.datetime :plan_frozen_date
      t.boolean :plan_frozen
      t.references :plannable, polymorphic: true

      t.timestamps
    end
  end
end
