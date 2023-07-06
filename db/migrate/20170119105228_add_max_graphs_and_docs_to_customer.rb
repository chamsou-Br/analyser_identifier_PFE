class AddMaxGraphsAndDocsToCustomer < ActiveRecord::Migration[4.2]
  def change
    add_column :customers, :max_graphs_and_docs, :integer, :default => -1
  end
end
