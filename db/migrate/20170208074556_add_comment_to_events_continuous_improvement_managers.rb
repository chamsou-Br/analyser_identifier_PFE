class AddCommentToEventsContinuousImprovementManagers < ActiveRecord::Migration[4.2]
  def change
    add_column :events_continuous_improvement_managers, :comment, :string
  end
end
