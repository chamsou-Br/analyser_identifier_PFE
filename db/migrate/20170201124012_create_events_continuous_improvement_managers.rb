class CreateEventsContinuousImprovementManagers < ActiveRecord::Migration[4.2]
  def change
    create_table :events_continuous_improvement_managers do |t|
      t.integer :event_id
      t.integer :continuous_improvement_manager_id

      t.timestamps
    end
  end
end
