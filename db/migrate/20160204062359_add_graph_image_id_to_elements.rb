class AddGraphImageIdToElements < ActiveRecord::Migration[4.2]
  def change
    add_column :elements, :graph_image_id, :integer
  end
end
