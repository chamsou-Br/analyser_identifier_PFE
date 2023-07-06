class RemoveRacFromFlags < ActiveRecord::Migration[4.2]
  def change
    remove_column :flags, :rac
  end
end
