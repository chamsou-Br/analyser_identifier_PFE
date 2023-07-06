class AddElementIdToLanes < ActiveRecord::Migration[4.2]
  def change
    add_column :lanes, :element_id, :integer
  end
end
