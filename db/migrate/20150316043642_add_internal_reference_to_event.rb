class AddInternalReferenceToEvent < ActiveRecord::Migration[4.2]
  def change
    add_column :events, :internal_reference, :string
  end
end
