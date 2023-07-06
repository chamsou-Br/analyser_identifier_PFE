class RemoveGripPanierInAndGripPanierOutFromElements < ActiveRecord::Migration[4.2]
  def change
    remove_column :elements, :grip_panier_in
    remove_column :elements, :grip_panier_out
  end
end
