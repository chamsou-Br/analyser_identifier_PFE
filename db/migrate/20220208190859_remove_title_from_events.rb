class RemoveTitleFromEvents < ActiveRecord::Migration[5.2]
  def change
    remove_column :events, :title, :string
  end
end
