class AddNewsToGraph < ActiveRecord::Migration[4.2]
  def change
    add_column :graphs, :news, :string, :limit => 765
  end
end
