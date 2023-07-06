class AddGripColumnsToElements < ActiveRecord::Migration[4.2]
  def change
    add_column :elements, :grip_panier_in, :string
    add_column :elements, :grip_panier_out, :string
  end
end
