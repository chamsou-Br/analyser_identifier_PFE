class AddPilotIdToGraphs < ActiveRecord::Migration[4.2]
  def change
  	add_column :graphs, :pilot_id, :integer, :default => nil
  	Graph.update_all(:pilot_id => nil)
  end
end
