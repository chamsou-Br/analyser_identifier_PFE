class AddCommentAndHistorizedToGraphsApprover < ActiveRecord::Migration[4.2]
  def change
    add_column :graphs_approvers, :comment, :string
    add_column :graphs_approvers, :historized, :boolean, :null => false, :default => false
  end
end
