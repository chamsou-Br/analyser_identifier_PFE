class AddStateIndex < ActiveRecord::Migration[4.2]
  def change
    add_index :acts, :state
    add_index :events, :state
    add_index :audits, :state
    add_index :graphs, :state
    add_index :documents, :state
  end
end
