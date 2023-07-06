class AddUidToGroupgraphs < ActiveRecord::Migration[4.2]
  def change
    add_column :groupgraphs, :uid, :string, after: :id
  end
end
