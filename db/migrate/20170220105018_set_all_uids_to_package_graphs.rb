class SetAllUidsToPackageGraphs < ActiveRecord::Migration[4.2]
  def change
    PackageGraph.all.order(:id).each do |package_graph|
      if !package_graph.graph.nil?
        package_graph.update_attribute(:graph_uid, package_graph.graph.uid)
        package_graph.update_attribute(:groupgraph_uid, package_graph.graph.groupgraph.uid)
      end
    end
  end
end
