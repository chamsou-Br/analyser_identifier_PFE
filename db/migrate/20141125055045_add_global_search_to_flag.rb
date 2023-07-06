class AddGlobalSearchToFlag < ActiveRecord::Migration[4.2]
  def change
    add_column :flags, :global_search, :boolean, :default => false
    Flag.update_all({:global_search => false})
  end
end
