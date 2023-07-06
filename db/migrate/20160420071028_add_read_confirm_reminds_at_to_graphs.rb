class AddReadConfirmRemindsAtToGraphs < ActiveRecord::Migration[4.2]
  def change
    add_column :graphs, :read_confirm_reminds_at, :datetime
  end
end
