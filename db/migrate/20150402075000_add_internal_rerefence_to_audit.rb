class AddInternalRerefenceToAudit < ActiveRecord::Migration[4.2]
  def change
    add_column :audits, :internal_reference, :string
  end
end
