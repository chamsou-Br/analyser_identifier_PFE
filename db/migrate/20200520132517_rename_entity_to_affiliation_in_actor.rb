class RenameEntityToAffiliationInActor < ActiveRecord::Migration[5.1]
  def change
    rename_column :actors, :entity_id, :affiliation_id
    rename_column :actors, :entity_type, :affiliation_type
  end
end
