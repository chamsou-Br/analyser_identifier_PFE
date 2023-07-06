class ChangeColumnGraphsDescriptionToDomain < ActiveRecord::Migration[4.2]
  def change
    rename_column :graphs, :description, :domain
  end
end
