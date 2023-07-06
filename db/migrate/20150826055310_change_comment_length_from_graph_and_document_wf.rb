class ChangeCommentLengthFromGraphAndDocumentWf < ActiveRecord::Migration[4.2]
  def up
    change_column :graphs_verifiers, :comment, :string, :limit => 765
    change_column :graphs_approvers, :comment, :string, :limit => 765
    change_column :graphs_logs, :comment, :string, :limit => 765

    change_column :documents_verifiers, :comment, :string, :limit => 765
    change_column :documents_approvers, :comment, :string, :limit => 765
    change_column :documents_logs, :comment, :string, :limit => 765
  end

  def down
  end
end
