class AddCommentAndHistorizedToGraphsVerifier < ActiveRecord::Migration[4.2]
  def change
    add_column :graphs_verifiers, :comment, :string
    add_column :graphs_verifiers, :historized, :boolean, :null => false, :default => false
  end
end
