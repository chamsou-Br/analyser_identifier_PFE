class AddPurposeToRoles < ActiveRecord::Migration[4.2]
  def change
    add_column :roles, :purpose, :string, :limit => 765
  end
end
