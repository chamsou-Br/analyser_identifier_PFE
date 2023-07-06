class AddUidToGroupdocuments < ActiveRecord::Migration[4.2]
  def change
    add_column :groupdocuments, :uid, :string, after: :id
  end
end
