class AddInternalReferenceToRisk < ActiveRecord::Migration[5.1]
  def change
    add_column :risks, :internal_reference, :string
  end
end
