class ChangeStartDateAndEndDateToAuditElement < ActiveRecord::Migration[4.2]
  def change
    change_column :audit_elements, :start_date, :datetime
    change_column :audit_elements, :end_date, :datetime
  end
end
