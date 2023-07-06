class AddIndexesToElements < ActiveRecord::Migration[4.2]
  def change
    add_index :elements, :model_id
    add_index :elements, :model_type
    add_index :elements, :type
    add_index :elements, :parent_role
    add_index :elements, :parent_id
    add_index :elements, :leasher_id
  end
end
