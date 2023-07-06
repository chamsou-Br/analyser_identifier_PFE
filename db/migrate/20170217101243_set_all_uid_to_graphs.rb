class SetAllUidToGraphs < ActiveRecord::Migration[4.2]
  def change
    i = 0
    Graph.all.order(:id).each do |graph|
      graph.generate_uid(i)
      graph.update_attribute(:uid, graph.uid)
      i += 1
    end
  end
end
