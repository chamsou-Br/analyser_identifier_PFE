class AddAuditOrganizerToUser < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :audits_organizer, :boolean, :default => true
  end
end
