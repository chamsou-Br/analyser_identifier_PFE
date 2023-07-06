class AddLeasherIdToElements < ActiveRecord::Migration[4.2]
  def change
    add_column :elements, :leasher_id, :integer
  end
end
