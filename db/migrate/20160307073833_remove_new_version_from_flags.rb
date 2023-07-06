class RemoveNewVersionFromFlags < ActiveRecord::Migration[4.2]
  def change
    remove_column :flags, :new_version
  end
end
