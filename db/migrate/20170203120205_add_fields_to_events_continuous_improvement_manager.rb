class AddFieldsToEventsContinuousImprovementManager < ActiveRecord::Migration[4.2]
  def change
    add_column :events_continuous_improvement_managers, :response, :boolean
    add_column :events_continuous_improvement_managers, :response_at, :datetime
  end
end
