class AddConfidentialToGraph < ActiveRecord::Migration[4.2]
  def change
    add_column :graphs, :confidential, :boolean, :default => false
    Graph.update_all(:confidential => false)
  end
end
