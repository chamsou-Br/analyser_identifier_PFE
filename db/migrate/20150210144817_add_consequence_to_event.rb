class AddConsequenceToEvent < ActiveRecord::Migration[4.2]
  def change
    add_column :events, :consequence, :string, limit: 765
  end
end
