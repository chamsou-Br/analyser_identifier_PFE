class ReaddStoreToFlags < ActiveRecord::Migration[4.2]
  def change
    add_column :flags, :store, :boolean, :default => true
  end
end
