class RemoveGraphContributionFromFlags < ActiveRecord::Migration[4.2]
  def change
    remove_column :flags, :graph_contribution
  end
end
