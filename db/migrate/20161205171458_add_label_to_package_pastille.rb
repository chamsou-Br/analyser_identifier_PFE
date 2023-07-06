class AddLabelToPackagePastille < ActiveRecord::Migration[4.2]
  def change
    add_column :package_pastilles, :label, :string, limit: 255
    remove_column :package_pastilles, :pastille_setting_id, :integer
  end
end
