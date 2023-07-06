class AddZindexToElements < ActiveRecord::Migration[4.2]
  def change
    add_column :elements, :zindex, :integer
  end
end
