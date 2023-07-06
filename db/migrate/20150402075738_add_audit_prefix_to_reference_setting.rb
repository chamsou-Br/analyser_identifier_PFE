class AddAuditPrefixToReferenceSetting < ActiveRecord::Migration[4.2]
  def change
    add_column :reference_settings, :audit_prefix, :string
  end
end
