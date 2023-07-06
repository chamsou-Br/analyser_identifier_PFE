class RemoveStoreFromFlags < ActiveRecord::Migration[4.2]
  def change
    remove_column :flags, :store
  end
end
