class AddStoreToFlags < ActiveRecord::Migration[4.2]
  def change
    add_column :flags, :store, :boolean, :default => false
  end
end
