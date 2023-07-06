class AddGraphContributionToFlag < ActiveRecord::Migration[4.2]
  def change
    add_column :flags, :graph_contribution, :boolean, :default => false
    Flag.update_all( :graph_contribution => false )
  end
end
