class AddReferencesToElements < ActiveRecord::Migration[4.2]
  def change
    add_column :elements, :elementable_id, :integer
    add_column :elements, :elementable_type, :string
  end
end
