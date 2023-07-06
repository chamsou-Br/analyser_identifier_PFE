class RemoveGlobalSearchFromFlag < ActiveRecord::Migration[4.2]
  def change
    remove_column :flags, :global_search, :boolean
  end
end
