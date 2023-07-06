class AddDefaultValuesToAuditor < ActiveRecord::Migration[5.0]
  def up
    change_column_default :audit_participants, :auditor, false
    change_column_default :audit_participants, :audited, false
  end

  def down
    change_column_default :audit_participants, :auditor, false
    change_column_default :audit_participants, :audited, false
  end
end
