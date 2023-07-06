class AddIndicatorsToFlags < ActiveRecord::Migration[4.2]
  def change
    add_column :flags, :indicators, :boolean, :default => false
  end
end
