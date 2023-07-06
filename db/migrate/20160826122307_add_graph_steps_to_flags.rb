class AddGraphStepsToFlags < ActiveRecord::Migration[4.2]
  def change
    add_column :flags, :graph_steps, :boolean, :default => true
  end
end
