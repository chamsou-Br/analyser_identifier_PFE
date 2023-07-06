class AddIndicatorToElements < ActiveRecord::Migration[4.2]
  def change
    add_column :elements, :indicator, :string
  end
end
