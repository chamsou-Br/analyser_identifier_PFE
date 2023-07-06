class AddAuditToReferenceCounter < ActiveRecord::Migration[4.2]
  def change
    add_column :reference_counters, :audit, :integer,default: 0
  end
end
