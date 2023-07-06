class AddReadConfirmRemindsAtToDocuments < ActiveRecord::Migration[4.2]
  def change
    add_column :documents, :read_confirm_reminds_at, :datetime
  end
end
