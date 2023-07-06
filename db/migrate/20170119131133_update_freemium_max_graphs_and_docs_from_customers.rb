class UpdateFreemiumMaxGraphsAndDocsFromCustomers < ActiveRecord::Migration[4.2]
  def change
    Customer.where(freemium: true).update_all(max_graphs_and_docs: 30)
  end
end
