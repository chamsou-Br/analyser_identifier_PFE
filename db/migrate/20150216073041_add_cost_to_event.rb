class AddCostToEvent < ActiveRecord::Migration[4.2]
  def change
    add_column :events, :cost, :string, limit: 765
  end
end
