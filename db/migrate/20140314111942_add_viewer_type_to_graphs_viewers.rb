class AddViewerTypeToGraphsViewers < ActiveRecord::Migration[4.2]
  def change
    add_column :graphs_viewers, :viewer_type, :string
    GraphsViewer.update_all({ :viewer_type => 'User' })
  end
end
