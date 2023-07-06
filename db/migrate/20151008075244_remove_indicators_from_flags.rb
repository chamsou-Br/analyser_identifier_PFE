class RemoveIndicatorsFromFlags < ActiveRecord::Migration[4.2]
  def change
    remove_column :flags, :indicators
  end
end
