class AddParentIdToFieldItems < ActiveRecord::Migration[4.2]
  def change
    add_reference :field_items, :parent, index: true
  end
end
