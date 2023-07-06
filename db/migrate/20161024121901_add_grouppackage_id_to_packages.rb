class AddGrouppackageIdToPackages < ActiveRecord::Migration[4.2]
  def change
    add_column :packages, :grouppackage_id, :integer
  end
end
