class AddTitleToImpactablesImpact < ActiveRecord::Migration[4.2]
  def change
    add_column :impactables_impacts, :title, :string
  end
end
