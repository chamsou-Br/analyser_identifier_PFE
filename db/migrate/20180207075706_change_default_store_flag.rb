class ChangeDefaultStoreFlag < ActiveRecord::Migration[4.2]
  def change
  	change_column :flags, :store, :boolean, :default => false
  end
end
