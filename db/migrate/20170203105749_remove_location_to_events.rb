class RemoveLocationToEvents < ActiveRecord::Migration[4.2]
  def change
    remove_column :events, :location, :string
  end
end
