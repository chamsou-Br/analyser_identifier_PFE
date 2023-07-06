class AddIndexToGroupgraphAndGroupdocument < ActiveRecord::Migration[4.2]

  add_index "graphs", ["groupgraph_id"], :name => "fk_graphs_groupgraph"
  add_index "documents", ["groupdocument_id"], :name => "fk_documents_groupdocument"

end
