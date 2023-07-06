class AddInternalReferenceToAct < ActiveRecord::Migration[4.2]
  def change
    add_column :acts, :internal_reference, :string
  end
end
