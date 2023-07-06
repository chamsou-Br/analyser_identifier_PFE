class AddGroupgraphIdToGraphs < ActiveRecord::Migration[4.2]
  def change
    add_column :graphs, :groupgraph_id, :integer
    Graph.where(:parent_id => nil).each do |graph|
      graph.groupgraph = Groupgraph.create(:customer_id => graph.customer_id, :type => graph.type, :level => graph.level)
      graph.save
      while !graph.child.nil?
        graph = graph.child
        graph.groupgraph = graph.parent.groupgraph
        graph.save
      end
    end
  end
end
