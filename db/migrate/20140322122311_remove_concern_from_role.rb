class RemoveConcernFromRole < ActiveRecord::Migration[4.2]
  def change
    remove_column :roles, :concern
  end
end
