class AddPilotIdToDocuments < ActiveRecord::Migration[4.2]
  def change
    add_column :documents, :pilot_id, :integer, :default => nil
    Document.update_all(:pilot_id => nil)
  end
end
